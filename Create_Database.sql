CREATE TABLE student (
  id INT GENERATED ALWAYS AS IDENTITY NOT NULL,
  person_number VARCHAR(16) UNIQUE,
  first_name VARCHAR(64),
  last_name VARCHAR(64),
  phone VARCHAR(16),
  mail VARCHAR(128),
  adress_street VARCHAR(64),
  adress_zip VARCHAR(8),
  adress_city VARCHAR(64),
  PRIMARY KEY (id)
);

CREATE TABLE instructor (
  id INT GENERATED ALWAYS AS IDENTITY NOT NULL,
  person_number VARCHAR(16),
  first_name VARCHAR(64),
  last_name VARCHAR(64),
  phone VARCHAR(16),
  mail VARCHAR(128),
  adress_street VARCHAR(64),
  adress_zip VARCHAR(8),
  adress_city VARCHAR(64),
  can_teach_ensembles BIT(1),
  PRIMARY KEY (id)
);

CREATE TABLE contact_person (
  id INT GENERATED ALWAYS AS IDENTITY NOT NULL,
  student_id INT NOT NULL,
  first_name VARCHAR(64) NOT NULL,
  last_name VARCHAR(64) NOT NULL,
  phone VARCHAR(16) NOT NULL,
  mail VARCHAR(128) NOT NULL,
  PRIMARY KEY (id),
  FOREIGN KEY (student_id) REFERENCES student(id) ON DELETE CASCADE
);

CREATE TABLE sibling_pair (
  id INT GENERATED ALWAYS AS IDENTITY NOT NULL,
  student_id_1 INT NOT NULL,
  student_id_2 INT NOT NULL,
  PRIMARY KEY (id),
  FOREIGN KEY (student_id_1) REFERENCES student(id) ON DELETE CASCADE,
  FOREIGN KEY (student_id_2) REFERENCES student(id) ON DELETE CASCADE
);

CREATE TABLE sibling_discount (
  id INT GENERATED ALWAYS AS IDENTITY NOT NULL,
  nr_active_siblings SMALLINT NOT NULL UNIQUE,
  discount_rate DECIMAL(4,3) NOT NULL,
  PRIMARY KEY (id)
);

CREATE TABLE lease_instrument (
  id INT GENERATED ALWAYS AS IDENTITY NOT NULL,
  instrument_type VARCHAR(64) NOT NULL,
  instrument_brand VARCHAR(64) NOT NULL,
  lease_active BIT(1) DEFAULT '0' NOT NULL,
  PRIMARY KEY (id)
);

CREATE TABLE lease_contract (
  id INT GENERATED ALWAYS AS IDENTITY NOT NULL,
  lease_start_date DATE NOT NULL,
  lease_end_date DATE NOT NULL,
  student_id INT NOT NULL,
  lease_instrument_id INT NOT NULL,
  PRIMARY KEY (id),
  FOREIGN KEY (student_id) REFERENCES student(id) ON DELETE CASCADE,
  FOREIGN KEY (lease_instrument_id) REFERENCES lease_instrument(id) ON DELETE CASCADE
);

CREATE TABLE lease_pricing (
  id INT GENERATED ALWAYS AS IDENTITY NOT NULL,
  instrument_type VARCHAR(64) NOT NULL,
  instrument_brand VARCHAR(64) NOT NULL,
  price_per_month DECIMAL(16,2) NOT NULL,
  PRIMARY KEY (id)
);

CREATE TABLE instructor_teachable_instrument (
  id INT GENERATED ALWAYS AS IDENTITY NOT NULL,
  instrument_type VARCHAR(64) NOT NULL,
  instructor_id INT NOT NULL,
  PRIMARY KEY (id),
  FOREIGN KEY (instructor_id) REFERENCES instructor(id) ON DELETE CASCADE
);

CREATE TABLE student_individual_lesson(
  id INT GENERATED ALWAYS AS IDENTITY NOT NULL,
  booked_date DATE NOT NULL,
  booked_time_start TIME NOT NULL,
  booked_time_end TIME NOT NULL,
  instrument_type VARCHAR(64) NOT NULL,
  instrument_skill_level SMALLINT NOT NULL,
  student_id INT NOT NULL,
  instructor_id INT NOT NULL,
  PRIMARY KEY (id),
  FOREIGN KEY (student_id) REFERENCES student(id) ON DELETE CASCADE,
  FOREIGN KEY (instructor_id) REFERENCES instructor(id) ON DELETE CASCADE
);

CREATE TABLE ensembles_lesson (
  id INT GENERATED ALWAYS AS IDENTITY NOT NULL,
  scheduled_date DATE NOT NULL,
  scheduled_time_slot SMALLINT NOT NULL,
  size_max SMALLINT NOT NULL,
  size_min SMALLINT NOT NULL,
  target_genre VARCHAR(64) NOT NULL,
  instructor_id INT NOT NULL,
  PRIMARY KEY (id),
  FOREIGN KEY (instructor_id) REFERENCES instructor(id) ON DELETE CASCADE
);

CREATE TABLE ensembles_instrument(
  id INT GENERATED ALWAYS AS IDENTITY NOT NULL,
  instrument_type VARCHAR(64) NOT NULL,
  ensembles_id INT NOT NULL,
  PRIMARY KEY (id),
  FOREIGN KEY (ensembles_id) REFERENCES ensembles_lesson(id) ON DELETE CASCADE
);

CREATE TABLE student_ensembles_lesson(
  id INT GENERATED ALWAYS AS IDENTITY NOT NULL,
  student_id INT NOT NULL,
  ensembles_lesson_id INT NOT NULL,
  PRIMARY KEY (id),
  FOREIGN KEY (student_id) REFERENCES student(id) ON DELETE CASCADE,
  FOREIGN KEY (ensembles_lesson_id) REFERENCES ensembles_lesson(id) ON DELETE CASCADE
);

CREATE TABLE group_lesson (
  id INT GENERATED ALWAYS AS IDENTITY NOT NULL,
  scheduled_date DATE NOT NULL,
  scheduled_time_slot SMALLINT NOT NULL,
  size_max SMALLINT NOT NULL,
  size_min SMALLINT NOT NULL,
  instrument_type VARCHAR(64) NOT NULL,
  instrument_skill_level SMALLINT NOT NULL,
  instructor_id INT NOT NULL,
  PRIMARY KEY (id),
  FOREIGN KEY (instructor_id) REFERENCES instructor(id) ON DELETE CASCADE
);

CREATE TABLE student_group_lesson(
  id INT GENERATED ALWAYS AS IDENTITY NOT NULL,
  student_id INT NOT NULL,
  group_lesson_id INT NOT NULL,
  PRIMARY KEY (id),
  FOREIGN KEY (student_id) REFERENCES student(id) ON DELETE CASCADE,
  FOREIGN KEY (group_lesson_id) REFERENCES group_lesson(id) ON DELETE CASCADE
);

CREATE TABLE lesson_pricing(
  id INT GENERATED ALWAYS AS IDENTITY NOT NULL,
  lesson_type VARCHAR(64) NOT NULL,
  lesson_skill_level SMALLINT NOT NULL,
  price_per_lesson DECIMAL(16,2) NOT NULL,
  PRIMARY KEY (id)
);

CREATE TABLE instructor_payment(
  id INT GENERATED ALWAYS AS IDENTITY NOT NULL,
  lesson_type VARCHAR(64) NOT NULL,
  lesson_skill_level SMALLINT NOT NULL,
  payment_per_lesson DECIMAL(16,2) NOT NULL,
  PRIMARY KEY (id)
);

CREATE TABLE student_application (
  id INT GENERATED ALWAYS AS IDENTITY NOT NULL,
  person_number VARCHAR(16),
  first_name VARCHAR(64),
  last_name VARCHAR(64),
  phone VARCHAR(16),
  mail VARCHAR(128),
  instrument_type VARCHAR(64),
  instrument_skill_level SMALLINT,
  adress_street VARCHAR(64),
  adress_zip VARCHAR(8),
  adress_city VARCHAR(64),
  PRIMARY KEY (id)
);