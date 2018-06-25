package starling.textures{   import flash.display3D.textures.TextureBase;   import flash.utils.getQualifiedClassName;      class ConcreteVideoTexture extends ConcreteTexture   {                   function ConcreteVideoTexture(base:TextureBase, scale:Number = 1) { super(null,null,null,null,null,null,null,null,null); }
            override public function get nativeWidth() : Number { return 0; }
            override public function get nativeHeight() : Number { return 0; }
            override public function get width() : Number { return 0; }
            override public function get height() : Number { return 0; }
   }}