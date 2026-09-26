show databases;
use healthcare_db;
show tables;
/*
1) Total Surgical Revenue by Specialty
Objective: Find out which type of surgery makes the most money for the hospital.
Conclusion: Tells management which surgery departments bring in high income so they can give them more operation rooms and better machines.
*/

select 
    s.surgery_type,
    count(sd.surgery_detail_id) as total_surgeries,
    sum(s.cost) as total_revenue
from surgery_detail sd
inner join surgery s
on sd.surgery_id = s.surgery_id
group by s.surgery_type
order by total_revenue desc;


/*
2) Doctor Consultation Workload
Objective: Count how many patients each doctor treated.
Conclusion: Shows which doctors are very busy or overloaded with patients so the hospital can hire more doctors there.
*/

select 
    d.doctor_name,
    d.specialization,
    count(e.encounter_id) as total_patients_treated
from doctor d
left join encounter e
on d.doctor_id = e.doctor_id
group by d.doctor_id, d.doctor_name, d.specialization
order by total_patients_treated desc;


/*
3) High-Demand Medication Analysis
Objective: Find which medicine is prescribed the most number of times.
Conclusion: Helps the hospital medical store know which medicines finish fast so they never run out of stock.
*/

select 
    m.med_name,
    count(mp.med_pres_id) as times_prescribed
from medication_prescription mp
inner join medication m
on mp.medication_id = m.medication_id
group by m.medication_id, m.med_name
order by times_prescribed desc;


/*
4) Diagnostic Lab Department Utilization
Objective: Find which lab department (like Blood test, X-ray) does the most tests.
Conclusion: Shows which lab is the busiest so the hospital can add more staff and keep testing machines ready without delays.
*/

select 
    t.test_dept,
    count(tr.test_report_id) as total_tests_conducted
from test_report tr
inner join test t
on tr.test_id = t.test_id
group by t.test_dept
order by total_tests_conducted desc;


/*
5) Patient Distribution by Encounter Type
Objective: Count how many patients came for Emergency, Normal OPD, or Inpatient stay.
Conclusion: Helps the hospital understand how many emergency beds and doctors are needed every day versus normal checkups.
*/

select 
    encounter_type,
    count(encounter_id) as total_visits
from encounter
group by encounter_type
order by total_visits desc;
