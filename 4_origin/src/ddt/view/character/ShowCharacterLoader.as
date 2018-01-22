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
      
      public function ShowCharacterLoader(param1:PlayerInfo)
      {
         super(param1);
      }
      
      override protected function initLayers() : void
      {
         if(_layers != null)
         {
            var _loc3_:int = 0;
            var _loc2_:* = _layers;
            for each(var _loc1_ in _layers)
            {
               _loc1_.dispose();
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
      
      private function loadPart(param1:int) : void
      {
         var _loc3_:* = null;
         var _loc2_:* = null;
         if(_recordStyle[param1].split("|")[0] > 0)
         {
            _loc3_ = ItemManager.Instance.getTemplateById(int(_recordStyle[param1].split("|")[0]));
            _loc2_ = !!EquipType.isEditable(_loc3_)?_recordColor[param1]:"";
            _layers.push(_layerFactory.createLayer(_loc3_,_info.Sex,_loc2_,"show",param1 == 2,_info.getHairType()));
         }
      }
      
      private function laodArm() : void
      {
         if(_recordStyle[6].split("|")[0] > 0)
         {
            _layers.push(_layerFactory.createLayer(ItemManager.Instance.getTemplateById(int(_recordStyle[6].split("|")[0])),_info.Sex,_recordColor[6],"show",false,_info.getHairType(),_recordStyle[6].split("|")[1]));
         }
      }
      
      override protected function getIndexByTemplateId(param1:String) : int
      {
         var _loc2_:int = super.getIndexByTemplateId(param1);
         if(_loc2_ == -1)
         {
            if(int(param1.charAt(0)) == 7)
            {
               return 7;
            }
            return -1;
         }
         return _loc2_;
      }
      
      public function set needMultiFrames(param1:Boolean) : void
      {
         _needMultiFrames = param1;
      }
      
      override protected function drawCharacter() : void
      {
         var _loc3_:* = null;
         var _loc5_:int = 0;
         var _loc4_:* = null;
         var _loc1_:Number = 250;
         var _loc6_:Number = 342;
         if(_needMultiFrames)
         {
            _loc1_ = _loc1_ * 2;
         }
         if(_content)
         {
            _content.dispose();
         }
         if(_contentWithoutWeapon)
         {
            _contentWithoutWeapon.dispose();
         }
         _content = new BitmapData(_loc1_,_loc6_,true,0);
         _contentWithoutWeapon = new BitmapData(_loc1_,_loc6_,true,0);
         var _loc2_:Matrix = new Matrix();
         _loc2_.identity();
         _loc2_.translate(_loc1_ / 2,0);
         _loc5_ = _layers.length - 1;
         while(_loc5_ >= 0)
         {
            if(_info.getShowSuits())
            {
               if(!(_loc5_ != 0 && _loc5_ != 8 && _loc5_ != 7))
               {
                  addr93:
                  _loc4_ = _layers[_loc5_];
                  if(_loc4_.info.CategoryID != 7 && _loc4_.info.CategoryID != 27 && !EquipType.isArmShell(_loc4_.info))
                  {
                     if(_loc4_.info.CategoryID == 15)
                     {
                        _wing = _loc4_.getContent() as MovieClip;
                     }
                     else if(_loc4_.info.CategoryID != 6 && _loc4_.info.CategoryID != 13)
                     {
                        _contentWithoutWeapon.draw(_loc4_.getContent(),null,null,"normal");
                        if(_needMultiFrames)
                        {
                           _contentWithoutWeapon.draw(_loc4_.getContent(),_loc2_,null,"normal");
                        }
                     }
                     else
                     {
                        _contentWithoutWeapon.draw(_loc4_.getContent(),null,null,"normal");
                     }
                  }
                  else if(_info.WeaponID != 0 && _info.WeaponID != -1 && _info.WeaponID != 70016)
                  {
                     _loc3_ = _loc4_.getContent();
                  }
               }
            }
            else if(_loc5_ != 0)
            {
               §§goto(addr93);
            }
            _loc5_--;
         }
         _content.draw(_contentWithoutWeapon);
         if(_loc3_ != null)
         {
            _content.draw(_loc3_);
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
