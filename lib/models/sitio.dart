part of aristadart.general;

class Sitio extends Ref
{
    @Field() String nombre;
    @Field() String descripcion;
    @Field() List<ImagenSlider> slider;
    @Field() List<Categoria> destacadas;
    @Field() List<Categoria> categorias;
}

