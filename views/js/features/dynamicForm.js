class DynamicForm {
    constructor(containerId) {
        this.container = document.getElementById(containerId);
        this.form = document.createElement("form");
        this.container.appendChild(this.form);
    }

    addField(type, name, label, options = []) {
        const fieldDiv = document.createElement("div");
        fieldDiv.className = "form-field";

        // Crear label
        const labelElement = document.createElement("label");
        labelElement.textContent = label;
        fieldDiv.appendChild(labelElement);

        // Crear input según el tipo
        switch (type) {
            case "select":
                const select = document.createElement("select");
                select.name = name;
                options.forEach((opt) => {
                    const option = document.createElement("option");
                    option.value = opt.value;
                    option.textContent = opt.label;
                    select.appendChild(option);
                });
                fieldDiv.appendChild(select);
                break;

            case "checkbox":
            case "radio":
                options.forEach((opt) => {
                    const wrapper = document.createElement("div");
                    const input = document.createElement("input");
                    input.type = type;
                    input.name = name;
                    input.value = opt.value;

                    const optionLabel = document.createElement("label");
                    optionLabel.textContent = opt.label;
                    optionLabel.prepend(input);

                    wrapper.appendChild(optionLabel);
                    fieldDiv.appendChild(wrapper);
                });
                break;

            default:
                const input = document.createElement("input");
                input.type = type;
                input.name = name;
                fieldDiv.appendChild(input);
        }

        // Botón para eliminar campo
        const removeBtn = document.createElement("button");
        removeBtn.type = "button";
        removeBtn.textContent = "❌";
        removeBtn.onclick = () => fieldDiv.remove();
        fieldDiv.appendChild(removeBtn);

        this.form.appendChild(fieldDiv);
    }

    onSubmit(callback) {
        const submitBtn = document.createElement("button");
        submitBtn.type = "submit";
        submitBtn.textContent = "Enviar";
        this.form.appendChild(submitBtn);

        this.form.onsubmit = (e) => {
            e.preventDefault();
            const formData = this.getFormData();
            callback(formData);
        };
    }

    getFormData() {
        const formData = {};
        const elements = this.form.elements;

        for (let element of elements) {
            if (!element.name || element.disabled) continue;

            switch (element.type) {
                case "checkbox":
                    if (element.checked) {
                        formData[element.name] = formData[element.name] || [];
                        formData[element.name].push(element.value);
                    }
                    break;

                case "radio":
                    if (element.checked) formData[element.name] = element.value;
                    break;

                case "submit":
                case "button":
                    break;

                default:
                    formData[element.name] = element.value;
            }
        }

        return formData;
    }
}

function createLocationSection(section) {
    const singularMap = {
        paises: "pais",
        estados: "estado",
        municipios: "municipio",
        parroquias: "parroquia",
        ciudades: "ciudad",
    };

    const singular = singularMap[section];
    if (!singular) {
        console.error("Sección no válida");
        return;
    }

    const codField = `cod${
        singular.charAt(0).toUpperCase() + singular.slice(1)
    }`;
    const nameField = `nombre${
        singular.charAt(0).toUpperCase() + singular.slice(1)
    }`;

    // Crear el formulario
    const form = new DynamicForm("formContainer");

    // Hacer la petición y crear el select
    fetchRequest(section)
        .then((response) => {
            const options = response.data.map((item) => ({
                value: item[codField],
                label: item[nameField],
            }));

            form.addField(
                "select",
                section,
                `Seleccione ${singular}:`,
                options
            );
        })
        .catch((error) => {
            console.error(`Error cargando ${section}:`, error);
            form.addField("text", section, `Error cargando ${singular}`, []);
        });
}

// Ejemplo de uso:
createLocationSection("paises");
createLocationSection("estados");
createLocationSection("municipios");
createLocationSection("parroquias");
createLocationSection("ciudades");

// Ejemplo de implementación simulada de fetchRequest
async function fetchRequest(endpoint) {
    // Simulación de petición HTTP
    const mockData = {
        paises: {
            data: [
                { codPais: 1, nombrePais: "Venezuela", estatus: "Activo" },
                { codPais: 2, nombrePais: "Colombia", estatus: "Activo" },
            ],
        },
        estados: {
            data: [
                {
                    codEstado: 1,
                    nombreEstado: "Nueva Esparta",
                    paises_codPais: 1,
                },
                { codEstado: 2, nombreEstado: "Zulia", paises_codPais: 1 },
            ],
        },
    };

    return new Promise((resolve) => {
        setTimeout(() => {
            resolve(mockData[endpoint] || { data: [] });
        }, 500);
    });
}
