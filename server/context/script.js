function getUsers() {
    fetch('http://localhost:3000/api/users')
        .then(response => response.json())
        .then(data => displayResults(data))
        .catch(error => console.error('Error:', error));
}

function getRoles() {
    fetch('http://localhost:3000/api/users/roles')
        .then(response => response.json())
        .then(data => displayResults(data))
        .catch(error => console.error('Error:', error));
}

function displayResults(data) {
    // Создание новой страницы для отображения результатов
    const resultPage = window.open('', '_blank');
    resultPage.document.write('<html><head><title>Results</title>');

    // Добавление стилей
    resultPage.document.write(`
        <style>
            body {
                margin: 0;
                font-family: Arial, sans-serif; /* Добавлен шрифт для лучшей читаемости */
            }

            .container {
                display: flex;
                justify-content: center;
                align-items: center;
                height: 100vh;
            }

            .table-container {
                width: 80%;
                overflow: auto;
            }

            table {
                width: 100%;
                border-collapse: collapse;
            }

            th, td {
                border: 1px solid #000000;
                text-align: left;
                padding: 8px;
            }

            th {
                background-color: #FD1D1DFF;
            }
        </style>
    `);

    resultPage.document.write('</head><body>');

    // Построение таблицы
    resultPage.document.write('<div class="container"><div class="table-container"><table>');

    // Добавление заголовков таблицы с именами полей пользователя
    resultPage.document.write('<thead><tr>');
    Object.keys(data[0]).forEach(key => {
        resultPage.document.write(`<th>${key}</th>`);
    });
    resultPage.document.write('</tr></thead>');

    resultPage.document.write('<tbody>');

    // Добавление строк с данными о пользователях
    data.forEach(user => {
        resultPage.document.write('<tr>');
        Object.values(user).forEach(value => {
            resultPage.document.write(`<td>${value}</td>`);
        });
        resultPage.document.write('</tr>');
    });

    resultPage.document.write('</tbody></table></div></div>');

    resultPage.document.write('</body></html>');
    resultPage.document.close();
}