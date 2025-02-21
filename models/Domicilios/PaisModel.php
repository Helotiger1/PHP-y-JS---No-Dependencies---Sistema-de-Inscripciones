<?php 
namespace App\Models\Domicilios;

class PaisModel extends ModelTerritorial{
    protected static $table = 'paises';
    protected static $primaryKey = 'codPais';
    protected static $fillable = ['nombrePais', 'estatus'];
    protected static $nameEntity = 'nombrePais';
}

?>