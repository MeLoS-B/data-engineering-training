-- Reconciliation Query: Aggregating expected and paid totals at order level before joining
WITH order_expected AS (
    SELECT order_id, ROUND(SUM(line_total), 2) AS expected_total
    FROM order_items
    GROUP BY order_id
),
order_payments AS (
    SELECT 
        order_id, 
        ROUND(SUM(CASE WHEN status = 'paid' THEN amount ELSE 0 END), 2) AS paid_total,
        ROUND(SUM(CASE WHEN status = 'refunded' THEN amount ELSE 0 END), 2) AS refunded_total,
        COUNT(payment_id) AS total_payments,
        COUNT(CASE WHEN status = 'paid' THEN 1 END) AS paid_payments_count,
        COUNT(CASE WHEN status = 'refunded' THEN 1 END) AS refunded_payments_count
    FROM payments
    GROUP BY order_id
)
SELECT 
    o.order_id,
    COALESCE(oe.expected_total, 0.0) AS expected_total,
    COALESCE(op.paid_total, 0.0) AS paid_total,
    COALESCE(op.refunded_total, 0.0) AS refunded_total,
    CASE 
        WHEN COALESCE(op.total_payments, 0) = 0 THEN 'Missing Payment'
        WHEN COALESCE(op.refunded_payments_count, 0) > 0 AND COALESCE(op.paid_payments_count, 0) = 0 THEN 'Refunded'
        WHEN ABS(COALESCE(op.paid_total, 0.0) - COALESCE(oe.expected_total, 0.0)) < 0.01 THEN 'Matched'
        WHEN COALESCE(op.paid_total, 0.0) < COALESCE(oe.expected_total, 0.0) AND COALESCE(op.paid_total, 0.0) > 0 THEN 'Underpaid'
        WHEN COALESCE(op.paid_total, 0.0) > COALESCE(oe.expected_total, 0.0) THEN 'Overpaid'
        ELSE 'Missing Payment'
    END AS reconciliation_status
FROM orders o
LEFT JOIN order_expected oe ON o.order_id = oe.order_id
LEFT JOIN order_payments op ON o.order_id = op.order_id;
