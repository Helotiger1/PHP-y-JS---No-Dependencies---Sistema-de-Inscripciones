async function fetchRequest(endpoint, method = 'GET', body = null) {
    let url = `http://localhost/proyecto/${endpoint}`;
    const options = {
      method,
      headers: {
        'Content-Type': 'application/json', 
      },
    };
  
    if (body) {
      options.body = JSON.stringify(body);
    }
  
    try {
      const response = await fetch(url, options);
  
      if (!response.ok) {
        throw new Error(`Error ${response.status}: ${response.statusText}`);
      }
      return await response.json(); 
    } catch (error) {
      console.error('Fetch Error:', error.message);
      throw error; 
    }
  }

// Mapeo de campos para los títulos de las tablas
const FIELD_NAMES = {
    codPais: 'Código',
    nombrePais: 'País',
    estatus: 'Estatus',
    codEstado: 'Código',
    nombreEstado: 'Estado',
    codMunicipio: 'Código',
    nombreMunicipio: 'Municipio',
    codParroquia: 'Código',
    nombreParroquia: 'Parroquia',
    codCiudad: 'Código',
    nombreCiudad: 'Ciudad'
};


async function loadData(section) {
    try {
        showLoading(true);
    //Esto es una cochinada pero fue como acople, jodanse.
    endpoint = section;
    method = "GET";
    let datos = await fetchRequest(endpoint, method);
    entidades = {[section] : datos}
    const data = entidades[section].data;
    renderTable(data, section);
    } catch (error) {
        console.error('Error:', error);
        mainContent.innerHTML = `<div class="alert alert-danger">Error cargando los datos</div>`;
    } finally {
        showLoading(false);
    }
}


function renderTable(data, section) {
    const table = document.getElementById('dataTable');
    const thead = table.querySelector('thead');
    const tbody = table.querySelector('tbody');
    const title = document.getElementById('tableTitle');
    
    // Limpiar tabla
    thead.innerHTML = '';
    tbody.innerHTML = '';
    
    // Configurar título
    title.textContent = `Tabla de ${section.charAt(0).toUpperCase() + section.slice(1)}`;
    
    // Crear headers
    const headers = Object.keys(data[0]);
    const headerRow = document.createElement('tr');
    
    headers.forEach(header => {
        const th = document.createElement('th');
        th.textContent = FIELD_NAMES[header] || header;
        headerRow.appendChild(th);
    });
    
    thead.appendChild(headerRow);
    
    // Llenar datos
    data.forEach(item => {
        const row = document.createElement('tr');
        headers.forEach(header => {
            const td = document.createElement('td');
            td.textContent = item[header];
            row.appendChild(td);
        });
        tbody.appendChild(row);
    });
}


function showLoading(show) {
    document.getElementById('loading').classList.toggle('d-none', !show);
}


// Event listeners para los enlaces
document.querySelectorAll('.nav-link').forEach(link => {
    link.addEventListener('click', (e) => {
        e.preventDefault();
        const section = e.target.dataset.section;
        loadData(section);
    });
});