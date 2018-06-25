package starling.scene.hall.player
{
   import ddt.manager.ItemManager;
   import flash.display.BitmapData;
   import flash.geom.Matrix;
   
   public class HallPlayerBodyLoader extends HallPlayerBaseLoader
   {
       
      
      private var _content:BitmapData;
      
      private var _color:Array;
      
      private var _style:Array;
      
      private var _sex:Boolean;
      
      private var _mountsType:int;
      
      public function HallPlayerBodyLoader(style:Array, color:Array, sex:Boolean, mountsType:int)
      {
         _style = style;
         _color = color;
         _sex = sex;
         _mountsType = mountsType;
         super();
      }
      
      override protected function setLoaderData() : void
      {
         var style:Array = _style;
         var color:Array = _color;
         if(_mountsType == 140)
         {
            _loaders.push(new HallSceneCharacterLayer(ItemManager.Instance.getTemplateById(int(style[4].split("|")[0])),color[4],1,_sex,2));
         }
         else
         {
            _loaders.push(new HallSceneCharacterLayer(ItemManager.Instance.getTemplateById(int(style[4].split("|")[0])),color[4],1,_sex,0));
            _loaders.push(new HallSceneCharacterLayer(ItemManager.Instance.getTemplateById(int(style[4].split("|")[0])),color[4],2,_sex,0));
            _loaders.push(new HallSceneCharacterLayer(ItemManager.Instance.getTemplateById(int(style[4].split("|")[0])),color[4],1,_sex,1));
         }
      }
      
      override protected function drawCharacter() : void
      {
         var i:* = 0;
         if(_loaders[0].width == 0 || _loaders[0].height == 0)
         {
            return;
         }
         _content = new BitmapData(1024,1024,true,0);
         for(i = uint(0); i < _loaders.length; )
         {
            if(!_loaders[i].isAllLoadSucceed)
            {
               _isAllLoadSucceed = false;
            }
            i++;
         }
         if(_mountsType == 140)
         {
            _content.draw(_loaders[0].getContent(),new Matrix(1,0,0,1,0,350),null,"normal");
         }
         else
         {
            _content.draw(_loaders[0].getContent(),null,null,"normal");
            _content.draw(_loaders[1].getContent(),null,null,"normal");
            _content.draw(_loaders[2].getContent(),new Matrix(1,0,0,1,0,_loaders[0].height),null,"normal");
         }
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
