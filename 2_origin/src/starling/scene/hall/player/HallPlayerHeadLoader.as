package starling.scene.hall.player
{
   import ddt.manager.ItemManager;
   import ddt.view.sceneCharacter.SceneCharacterLayer;
   import flash.display.BitmapData;
   
   public class HallPlayerHeadLoader extends HallPlayerBaseLoader
   {
       
      
      private var _content:BitmapData;
      
      private var _color:Array;
      
      private var _style:Array;
      
      public function HallPlayerHeadLoader(param1:Array, param2:Array)
      {
         _style = param1;
         _color = param2;
         super();
      }
      
      override protected function setLoaderData() : void
      {
         var _loc1_:Array = _style;
         var _loc2_:Array = _color;
         _loaders.push(new SceneCharacterLayer(ItemManager.Instance.getTemplateById(int(_loc1_[5].split("|")[0])),_loc2_[5]));
         _loaders.push(new SceneCharacterLayer(ItemManager.Instance.getTemplateById(int(_loc1_[2].split("|")[0])),_loc2_[2]));
         _loaders.push(new SceneCharacterLayer(ItemManager.Instance.getTemplateById(int(_loc1_[3].split("|")[0])),_loc2_[3]));
      }
      
      override protected function drawCharacter() : void
      {
         var _loc2_:* = 0;
         var _loc1_:Number = _loaders[0].width;
         var _loc3_:Number = _loaders[0].height;
         if(_loc1_ == 0 || _loc3_ == 0)
         {
            return;
         }
         _content = new BitmapData(512,512,true,0);
         _loc2_ = uint(0);
         while(_loc2_ < _loaders.length)
         {
            if(!_loaders[_loc2_].isAllLoadSucceed)
            {
               _isAllLoadSucceed = false;
            }
            _loc2_++;
         }
         _content.draw(_loaders[0].getContent(),null,null,"normal");
         _content.draw(_loaders[1].getContent(),null,null,"normal");
         _content.draw(_loaders[2].getContent(),null,null,"normal");
      }
      
      override public function get content() : Object
      {
         return _content;
      }
      
      override public function dispose() : void
      {
         super.dispose();
         if(_content)
         {
            _content.dispose();
         }
         _content = null;
         _color = null;
         _style = null;
      }
   }
}
