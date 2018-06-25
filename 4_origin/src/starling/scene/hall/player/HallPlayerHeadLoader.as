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
      
      public function HallPlayerHeadLoader(style:Array, color:Array)
      {
         _style = style;
         _color = color;
         super();
      }
      
      override protected function setLoaderData() : void
      {
         var style:Array = _style;
         var color:Array = _color;
         _loaders.push(new SceneCharacterLayer(ItemManager.Instance.getTemplateById(int(style[5].split("|")[0])),color[5]));
         _loaders.push(new SceneCharacterLayer(ItemManager.Instance.getTemplateById(int(style[2].split("|")[0])),color[2]));
         _loaders.push(new SceneCharacterLayer(ItemManager.Instance.getTemplateById(int(style[3].split("|")[0])),color[3]));
      }
      
      override protected function drawCharacter() : void
      {
         var i:* = 0;
         var picWidth:Number = _loaders[0].width;
         var picHeight:Number = _loaders[0].height;
         if(picWidth == 0 || picHeight == 0)
         {
            return;
         }
         _content = new BitmapData(512,512,true,0);
         for(i = uint(0); i < _loaders.length; )
         {
            if(!_loaders[i].isAllLoadSucceed)
            {
               _isAllLoadSucceed = false;
            }
            i++;
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
