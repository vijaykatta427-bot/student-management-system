// ==========================================
// STUDENTS PAGE - SEARCH & FILTER
// ==========================================

const searchInput = document.getElementById("searchStudent");
const departmentFilter = document.getElementById("departmentFilter");
const studentTable = document.getElementById("studentTable");


// ==========================================
// ADD STUDENT
// ==========================================

// ==========================================
// ADD / UPDATE STUDENT
// ==========================================

const studentForm = document.getElementById("studentForm");

if (studentForm) {

    const editIndex = localStorage.getItem("editStudentIndex");

    // Load existing student when editing
    if (editIndex !== null) {

        const students =
            JSON.parse(localStorage.getItem("students")) || [];

        const student = students[editIndex];

        if (student) {
            document.getElementById("studentName").value = student.name;
            document.getElementById("rollNumber").value = student.rollNumber;
            document.getElementById("department").value = student.department;
            document.getElementById("year").value = student.year;
            document.getElementById("email").value = student.email;
            document.getElementById("phone").value = student.phone;
            document.getElementById("address").value = student.address;

            document.querySelector(".topbar h1").textContent =
                "Edit Student";

            document.querySelector(".topbar p").textContent =
                "Update student information";

            document.querySelector(".save-button").textContent =
                "Update Student";
        }
    }


    // Submit form
    studentForm.addEventListener("submit", function(event) {

        event.preventDefault();

        const student = {
            name: document.getElementById("studentName").value,
            rollNumber: document.getElementById("rollNumber").value,
            department: document.getElementById("department").value,
            year: document.getElementById("year").value,
            email: document.getElementById("email").value,
            phone: document.getElementById("phone").value,
            address: document.getElementById("address").value
        };

        let students =
            JSON.parse(localStorage.getItem("students")) || [];


        // UPDATE existing student
        if (editIndex !== null) {

            students[editIndex] = student;

            localStorage.removeItem("editStudentIndex");

            localStorage.setItem(
                "students",
                JSON.stringify(students)
            );

            alert("Student updated successfully!");

        }

        // ADD new student
        else {

            students.push(student);

            localStorage.setItem(
                "students",
                JSON.stringify(students)
            );

            alert("Student added successfully!");
        }

        window.location.href = "students.html";
    });
}

// ==========================================
// DISPLAY SAVED STUDENTS
// ==========================================

function displayStudents() {

    if (!studentTable) {
        return;
    }

    const tableBody = studentTable.querySelector("tbody");

    const students = JSON.parse(localStorage.getItem("students")) || [];

    students.forEach(function(student, index) {

        const row = document.createElement("tr");

        row.innerHTML = `
            <td>${index + 4}</td>
            <td>${student.name}</td>
            <td>${student.rollNumber}</td>
            <td>${student.department}</td>
            <td>${student.year}</td>
            <td>${student.email}</td>
            <td>
                <button class="view-btn" data-index="${index}">
                    View
                </button>
                <button class="edit-btn" data-index="${index}">
    Edit
</button>
            </td>
        `;

        tableBody.appendChild(row);
    });
}


// Run display function
displayStudents();


// ==========================================
// SEARCH & DEPARTMENT FILTER
// ==========================================

if (searchInput && departmentFilter && studentTable) {

    function filterStudents() {

        const searchValue =
            searchInput.value.toLowerCase();

        const departmentValue =
            departmentFilter.value;

        const rows =
            studentTable.querySelectorAll("tbody tr");

        rows.forEach(function(row) {

            const name =
                row.cells[1].textContent.toLowerCase();

            const rollNumber =
                row.cells[2].textContent.toLowerCase();

            const department =
                row.cells[3].textContent;

            const matchesSearch =
                name.includes(searchValue) ||
                rollNumber.includes(searchValue);

            const matchesDepartment =
                departmentValue === "" ||
                department === departmentValue;

            if (matchesSearch && matchesDepartment) {
                row.style.display = "";
            } else {
                row.style.display = "none";
            }
        });
    }

    searchInput.addEventListener(
        "input",
        filterStudents
    );

    departmentFilter.addEventListener(
        "change",
        filterStudents
    );
}
// ==========================================
// VIEW STUDENT
// ==========================================

const viewButtons = document.querySelectorAll(".view-btn");

viewButtons.forEach(function(button) {

    button.addEventListener("click", function() {

        const index = this.getAttribute("data-index");

        const students =
            JSON.parse(localStorage.getItem("students")) || [];

        const student = students[index];

        alert(
            "STUDENT DETAILS\n\n" +
            "Name: " + student.name + "\n" +
            "Roll Number: " + student.rollNumber + "\n" +
            "Department: " + student.department + "\n" +
            "Year: " + student.year + "\n" +
            "Email: " + student.email + "\n" +
            "Phone: " + student.phone + "\n" +
            "Address: " + student.address
        );
    });
});
// ==========================================
// EDIT STUDENT
// ==========================================

const editButtons = document.querySelectorAll(".edit-btn");

editButtons.forEach(function(button) {

    button.addEventListener("click", function() {

        const index = this.getAttribute("data-index");

        localStorage.setItem("editStudentIndex", index);

        window.location.href = "add-student.html";
    });
});
// ==========================================
// LOAD STUDENT FOR EDITING
// ==========================================

const editIndex = localStorage.getItem("editStudentIndex");

if (studentForm && editIndex !== null) {

    const students =
        JSON.parse(localStorage.getItem("students")) || [];

    const student = students[editIndex];

    if (student) {

        document.getElementById("studentName").value = student.name;
        document.getElementById("rollNumber").value = student.rollNumber;
        document.getElementById("department").value = student.department;
        document.getElementById("year").value = student.year;
        document.getElementById("email").value = student.email;
        document.getElementById("phone").value = student.phone;
        document.getElementById("address").value = student.address;

        document.querySelector(".topbar h1").textContent =
            "Edit Student";

        document.querySelector(".topbar p").textContent =
            "Update student information";

        document.querySelector(".save-button").textContent =
            "Update Student";
    }
}