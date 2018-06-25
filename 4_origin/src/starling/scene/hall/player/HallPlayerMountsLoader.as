package starling.scene.hall.player
{
   import com.pickgliss.utils.ObjectUtils;
   
   public class HallPlayerMountsLoader extends HallPlayerBaseLoader
   {
       
      
      private var _content:Object;
      
      private var _type:int;
      
      public function HallPlayerMountsLoader(type:int)
      {
         _type = type;
         super();
      }
      
      override protected function setLoaderData() : void
      {
         _loaders.push(new HallSceneMountsLayer(_type));
      }
      
      override protected function drawCharacter() : void
      {
         var layer:HallSceneMountsLayer = _loaders[0] as HallSceneMountsLayer;
         _content = {};
         _content.image = layer.image;
         _content.xml = layer.xml;
      }
      
      override public function get content() : Object
      {
         return _content;
      }
      
      override public function dispose() : void
      {
         if(_content)
         {
            ObjectUtils.disposeObject(_content.image);
            _content.xml = null;
         }
         _content = null;
         super.dispose();
      }
   }
}
