<?php
namespace App\Controllers\Inscripciones;

use App\Models\Inscripciones\ContactoModel;
use App\Models\Inscripciones\PersonaModel;
use App\Models\Inscripciones\RepresentanteModel;

class RepresentanteController extends Controller{
    protected static $nombreEntidad = RepresentanteModel::class;

    public static function store($params){

        $params = $params["body"];
        $persona = $params["personas"];
        $representante = $params["representantes"];
        $contacto  = $params["contactos"];

        $contacto_id = ContactoModel::create($contacto);
        $representante["contacto_idContacto"] = $contacto_id;

        $persona_id = PersonaModel::create($persona);
        $representante["personas_idPersona"] = $persona_id;

        $entidad = static::$nombreEntidad::create($representante);
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

        $representante = $params["representantes"];

        $entidad = static::$nombreEntidad::update($id, $representante);
        return $entidad;
    }
}
?>