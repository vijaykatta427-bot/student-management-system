const searchInput = document.getElementById("searchStudent");
const departmentFilter = document.getElementById("departmentFilter");
const studentTable = document.getElementById("studentTable");

function filterStudents() {

    const searchValue = searchInput.value.toLowerCase();
    const departmentValue = departmentFilter.value;

    const rows = studentTable.querySelectorAll("tbody tr");

    rows.forEach(row => {

        const name = row.cells[1].textContent.toLowerCase();
        const rollNumber = row.cells[2].textContent.toLowerCase();
        const department = row.cells[3].textContent;

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

searchInput.addEventListener("input", filterStudents);

departmentFilter.addEventListener("change", filterStudents);