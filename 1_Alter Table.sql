1. Đổi tên bảng countries thành country_new

ALTER TABLE countries RENAME TO country_new;

2. Thêm cột region_id tới bảng locations 

ALTER TABLE locations ADD COLUMN region_id number;

3. Thêm cột ID vào bảng locations với điều kiện cột ID là cột đầu tiên của bảng.

ALTER TABLE locations DROP COLUMN location_id;
ALTER TABLE locations DROP COLUMN street_address;
ALTER TABLE locations DROP COLUMN postal_code;
ALTER TABLE locations DROP COLUMN city;
ALTER TABLE locations DROP COLUMN state_province;
ALTER TABLE locations DROP COLUMN country_id;

ALTER TABLE locations ADD COLUMN ID number;
ALTER TABLE locations ADD COLUMN location_id number primary key;
ALTER TABLE locations ADD COLUMN street_address varchar2(25);
ALTER TABLE locations ADD COLUMN postal_code varchar2(12);
ALTER TABLE locations ADD COLUMN city varchar2(30);
ALTER TABLE locations ADD COLUMN state_province archar2(12);
ALTER TABLE locations ADD COLUMN country_id char(2) references countries(country_id);

4. Thêm cột region_id đứng liền sau cột state_province của bảng locations.

ALTER TABLE locations DROP COLUMN country_id;
ALTER TABLE locations ADD COLUMN region_id number;

ALTER TABLE locations ADD COLUMN state_province archar2(12);
ALTER TABLE locations ADD COLUMN country_id char(2) references countries(country_id);

5. Thay đổi kiểu dữ liệu của cột country_id thành integer trong bảng locations. 

ALTER TABLE locations ALTER COLUMN country_id TYPE integer;

6. Xóa cột city trong bảng locations

ALTER TABLE locations DROP COLUMN city;

7. Đổi tên cột state_province thành cột state, giữa nguyên kiểu và kích thước của cột. 

ALTER TABLE locations RENAME COLUMN state_province TO state;

8. Thêm khóa chính cho cột location_id trong bảng locations 

ALTER TABLE locations ADD primary key (location_id);

9. Thêm khóa chính là cặp 2 cột (location_id, country_id) cho bảng locations.

ALTER TABLE locations ADD primary key (location_id,country_id);

10. Xóa khóa chính là cặp (location_id, country_id) đã tạo.

ALTER TABLE locations DROP primary key (location_id,country_id);

11. Tạo khóa ngoại job_id cho bảng job_history mà tham chiếu tới job_id của bảng jobs.

ALTER TABLE job_history ADD FOREIGN KEY (job_id) REFERENCES jobs;

12. Tạo ràng buộc có tên là fk_job_id với job_id của bảng job_history tham chiếu tới job_id của bảng jobs. 

ALTER TABLE job_history ADD CONSTRAINT fk_job_id FOREIGN KEY (job_id) REFERENCES jobs(job_id);

13. Xóa khóa ngoại fk_job_id trong bảng job_history đã tạo. 

ALTER TABLE job_history DROP CONSTRAINT fk_job_id;

14. Thêm chỉ mục có tên indx_job_id trên thuộc tính job_id của bảng job_history.

CREATE UNIQUE INDEX indx_job_id ON job_history (job_id);

15. Xóa chỉ mục indx_job_id trong bảng job_history. 

DROP INDEX indx_job_id;