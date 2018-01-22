package starling.scene.hall.player
{
   import com.pickgliss.utils.ObjectUtils;
   
   public class HallPlayerMountsLoader extends HallPlayerBaseLoader
   {
       
      
      private var _content:Object;
      
      private var _type:int;
      
      public function HallPlayerMountsLoader(param1:int)
      {
         _type = param1;
         super();
      }
      
      override protected function setLoaderData() : void
      {
         _loaders.push(new HallSceneMountsLayer(_type));
      }
      
      override protected function drawCharacter() : void
      {
         var _loc1_:HallSceneMountsLayer = _loaders[0] as HallSceneMountsLayer;
         _content = {};
         _content.image = _loc1_.image;
         _content.xml = _loc1_.xml;
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
