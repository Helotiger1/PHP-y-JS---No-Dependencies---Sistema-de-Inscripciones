<?php 
namespace App\Controllers\Inscripciones;
use App\Models\Inscripciones\EstudianteModel;
use App\Models\Inscripciones\ContactoModel;
use App\Models\Inscripciones\PersonaModel;

class EstudianteController extends Controller{
    protected static $nombreEntidad = EstudianteModel::class;

    public static function store($params){
        $params = $params["body"];
        $persona = $params["personas"];
        $estudiante = $params["estudiantes"];
        $contacto  = $params["contactos"];
        
        $contacto_id = ContactoModel::create($contacto);
        $estudiante["contacto_idContacto"] = $contacto_id;

        $persona_id = PersonaModel::create($persona);
        $estudiante["personas_idPersona"] = $persona_id;

        $entidad = static::$nombreEntidad::create($estudiante);
        return $entidad;
        
    }

    public static function update($params){

        $id = $params["id"];
        $params = $params["body"];


        $persona = $params["personas"];
        $persona_id = $params["personas_idPersona"];
        $persona_id = PersonaModel::update($persona_id, $persona);

        $contacto  = $params["contactos"];
        $contacto_id = $params["contacto_idContacto"];
        $contacto_id = ContactoModel::update($contacto_id, $contacto);

        $estudiantes = $params["estudiantes"];

        $entidad = static::$nombreEntidad::update($id, $estudiantes);
        return $entidad;
    }
    
}
?>