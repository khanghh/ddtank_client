package ddt.view.character
{
   import ddt.data.EquipType;
   import ddt.data.goods.ItemTemplateInfo;
   import ddt.data.player.PlayerInfo;
   import ddt.manager.ItemManager;
   import flash.display.BitmapData;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.geom.Matrix;
   
   public class ShowCharacterLoader extends BaseCharacterLoader
   {
       
      
      protected var _contentWithoutWeapon:BitmapData;
      
      private var _needMultiFrames:Boolean = false;
      
      public function ShowCharacterLoader(info:PlayerInfo)
      {
         super(info);
      }
      
      override protected function initLayers() : void
      {
         if(_layers != null)
         {
            var _loc3_:int = 0;
            var _loc2_:* = _layers;
            for each(var layer in _layers)
            {
               layer.dispose();
            }
            _layers = null;
         }
         _layers = new Vector.<ILayer>();
         _recordStyle = _info.Style.split(",");
         _recordColor = _info.Colors.split(",");
         loadPart(7);
         loadPart(1);
         loadPart(0);
         loadPart(3);
         loadPart(4);
         loadPart(2);
         loadPart(5);
         laodArm();
         loadPart(8);
      }
      
      private function loadPart(index:int) : void
      {
         var item:* = null;
         var color:* = null;
         if(_recordStyle[index].split("|")[0] > 0)
         {
            item = ItemManager.Instance.getTemplateById(int(_recordStyle[index].split("|")[0]));
            color = !!EquipType.isEditable(item)?_recordColor[index]:"";
            _layers.push(_layerFactory.createLayer(item,_info.Sex,color,"show",index == 2,_info.getHairType()));
         }
      }
      
      private function laodArm() : void
      {
         if(_recordStyle[6].split("|")[0] > 0)
         {
            _layers.push(_layerFactory.createLayer(ItemManager.Instance.getTemplateById(int(_recordStyle[6].split("|")[0])),_info.Sex,_recordColor[6],"show",false,_info.getHairType(),_recordStyle[6].split("|")[1]));
         }
      }
      
      override protected function getIndexByTemplateId(id:String) : int
      {
         var i:int = super.getIndexByTemplateId(id);
         if(i == -1)
         {
            if(int(id.charAt(0)) == 7)
            {
               return 7;
            }
            return -1;
         }
         return i;
      }
      
      public function set needMultiFrames(value:Boolean) : void
      {
         _needMultiFrames = value;
      }
      
      override protected function drawCharacter() : void
      {
         var weapon:* = null;
         var i:int = 0;
         var layer:* = null;
         var picWidth:Number = 250;
         var picHeight:Number = 342;
         if(_needMultiFrames)
         {
            picWidth = picWidth * 2;
         }
         if(_content)
         {
            _content.dispose();
         }
         if(_contentWithoutWeapon)
         {
            _contentWithoutWeapon.dispose();
         }
         _content = new BitmapData(picWidth,picHeight,true,0);
         _contentWithoutWeapon = new BitmapData(picWidth,picHeight,true,0);
         var mt:Matrix = new Matrix();
         mt.identity();
         mt.translate(picWidth / 2,0);
         for(i = _layers.length - 1; i >= 0; )
         {
            if(_info.getShowSuits())
            {
               if(!(i != 0 && i != 8 && i != 7))
               {
                  addr117:
                  layer = _layers[i];
                  if(layer.info.CategoryID != 7 && layer.info.CategoryID != 27 && !EquipType.isArmShell(layer.info))
                  {
                     if(layer.info.CategoryID == 15)
                     {
                        _wing = layer.getContent() as MovieClip;
                     }
                     else if(layer.info.CategoryID != 6 && layer.info.CategoryID != 13)
                     {
                        _contentWithoutWeapon.draw(layer.getContent(),null,null,"normal");
                        if(_needMultiFrames)
                        {
                           _contentWithoutWeapon.draw(layer.getContent(),mt,null,"normal");
                        }
                     }
                     else
                     {
                        _contentWithoutWeapon.draw(layer.getContent(),null,null,"normal");
                     }
                  }
                  else if(_info.WeaponID != 0 && _info.WeaponID != -1 && _info.WeaponID != 70016)
                  {
                     weapon = layer.getContent();
                  }
               }
            }
            else if(i != 0)
            {
               §§goto(addr117);
            }
            i--;
         }
         _content.draw(_contentWithoutWeapon);
         if(weapon != null)
         {
            _content.draw(weapon);
         }
      }
      
      override public function dispose() : void
      {
         super.dispose();
         _content = null;
         _contentWithoutWeapon = null;
      }
      
      public function destory() : void
      {
         _content.dispose();
         _contentWithoutWeapon.dispose();
         dispose();
      }
      
      override public function getContent() : Array
      {
         return [_content,_contentWithoutWeapon,_wing];
      }
   }
}
