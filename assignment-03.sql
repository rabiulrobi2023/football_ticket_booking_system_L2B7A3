-- =============================================================================
--                       PART-01
-- =============================================================================

-- ⚠️Delete Tables==========================================
DROP TABLE IF EXISTS Bookings;

DROP TABLE IF EXISTS Matches;

DROP TABLE IF EXISTS Users;

-- Create Tables============================================
CREATE TABLE Users (
    user_id serial PRIMARY KEY,
    full_name VARCHAR(50) NOT NULL,
    email VARCHAR(50) NOT NULL UNIQUE,
    role VARCHAR(30) CHECK (role IN ('Football Fan', 'Ticket Manager')) NOT NULL,
    phone_number VARCHAR(14)
);

CREATE TABLE Matches (
    match_id serial PRIMARY KEY,
    fixture VARCHAR(50) NOT NULL,
    tournament_category VARCHAR(50) NOT NULL,
    base_ticket_price INT CHECK (base_ticket_price >= 0) NOT NULL,
    match_status VARCHAR(30) NOT NULL CHECK (
        match_status IN (
            'Available',
            'Selling Fast',
            'Sold Out',
            'Postponed'
        )
    )
);

CREATE TABLE Bookings (
    booking_id serial PRIMARY KEY,
    user_id INT REFERENCES users (user_id) NOT NULL,
    match_id INT REFERENCES matches (match_id) NOT NULL,
    seat_number VARCHAR(8),
    payment_status VARCHAR(10) CHECK (
        payment_status IN ('Pending', 'Confirmed', 'Cancelled', 'Refunded')
    ),
    total_cost INT CHECK (total_cost >= 0) NOT NULL
)


--  Get All Tables Data============================================
SELECT * FROM users;

SELECT * FROM matches;

SELECT * FROM bookings;

-- =============================================================================
--                       PART-02
-- =============================================================================
-- Query-1======================================================================
SELECT
	match_id,
	fixture,
	base_ticket_price
FROM
	matches
WHERE
	tournament_category = 'Champions League'
	AND match_status = 'Available';

-- Query-2======================================================================
SELECT
    user_id,
    full_name,
    email
FROM
    users
WHERE
    full_name ILIKE 'Tanvir%'
    OR full_name ILIKE '%Haque%'

-- Query-3======================================================================
SELECT
    booking_id,
    user_id,
    match_id,
    COALESCE(payment_status, 'Action Required') AS "systematic_status"
FROM
    bookings
WHERE
    payment_status IS NULL;