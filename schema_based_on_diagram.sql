CREATE TABLE medical_histories(
    id INTEGER NOT NULL,
    admitted_at TIMESTAMP(0) WITHOUT TIME ZONE NOT NULL,
    patient_id INTEGER NOT NULL,
    status VARCHAR(255) NOT NULL,
    PRIMARY KEY(id)
);
CREATE INDEX medical_histories_patient_id_index ON medical_histories(patient_id);


CREATE TABLE patients(
    id INTEGER NOT NULL,
    name VARCHAR(255) NOT NULL,
    date_of_birth DATE NOT NULL,
    PRIMARY KEY(id)
);


CREATE TABLE invoices(
    id INTEGER NOT NULL,
    total_amount DECIMAL(8, 2) NOT NULL,
    generated_at TIMESTAMP(0) WITHOUT TIME ZONE NOT NULL,
    payed_at TIMESTAMP(0) WITHOUT TIME ZONE NOT NULL,
    medical_history_id INTEGER NOT NULL,
    PRIMARY KEY(id)
);
CREATE INDEX invoices_medical_history_id_index ON invoices(medical_history_id);


CREATE TABLE invoice_items(
    id INTEGER NOT NULL,
    unit_price DECIMAL(8, 2) NOT NULL,
    quantity INTEGER NOT NULL,
    total_price DECIMAL(8, 2) NOT NULL,
    invoice_id INTEGER NOT NULL,
    treatment_id INTEGER NOT NULL,
    PRIMARY KEY(id)
);
CREATE INDEX invoice_items_treatment_id_index ON invoice_items(treatment_id);

CREATE TABLE treatments(
    id INTEGER NOT NULL,
    type VARCHAR(255) NOT NULL,
    name VARCHAR(255) NOT NULL,
    PRIMARY KEY(id);
);

CREATE TABLE medical_history_treatments (
    medical_history_id  INT,
    treatment_id     INT,
    PRIMARY KEY (medical_history_id, treatment_id)
);

ALTER TABLE invoices ADD  FOREIGN KEY(medical_history_id) REFERENCES medical_histories(id);
ALTER TABLE medical_histories ADD FOREIGN KEY(patient_id) REFERENCES patients(id);
ALTER TABLE invoice_items ADD FOREIGN KEY(invoice_id) REFERENCES invoices(id);
ALTER TABLE invoice_items ADD FOREIGN KEY(treatment_id) REFERENCES treatments(id);
ALTER TABLE medical_history_treatments ADD FOREIGN KEY (medical_history_id) REFERENCES medical_histories (id);
ALTER TABLE medical_history_treatments ADD FOREIGN KEY (treatment_id) REFERENCES treatments (id);