<?php 
namespace App\Controllers\Inscripciones;
use App\Models\Inscripciones\MaestroModel;
use App\Models\Inscripciones\ContactoModel;
use App\Models\Inscripciones\PersonaModel;


class MaestroController extends Controller{
    protected static $nombreEntidad = MaestroModel::class;

    public static function store($params){
        $params = $params["body"];
        $persona = $params["personas"];
        $maestro = $params["maestros"];
        $contacto  = $params["contactos"];
        
        $contacto_id = ContactoModel::create($contacto);
        $maestro["contacto_idContacto"] = $contacto_id;

        $persona_id = PersonaModel::create($persona);
        $maestro["personas_idPersona"] = $persona_id;

        $entidad = static::$nombreEntidad::create($maestro);
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

        $maestros = $params["maestros"];

        $entidad = static::$nombreEntidad::update($id, $maestros);
        return $entidad;
    }


}
?>