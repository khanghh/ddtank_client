package ddt.view
{
   import bombKing.data.BKingStatueInfo;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.text.GradientText;
   import com.pickgliss.utils.DisplayUtils;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.player.BasePlayer;
   import ddt.data.player.PlayerInfo;
   import ddt.utils.PositionUtils;
   import ddt.view.character.CharactoryFactory;
   import ddt.view.character.ShowCharacter;
   import ddt.view.common.VipLevelIcon;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.filters.ColorMatrixFilter;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import phy.maps.Tile;
   import vip.VipController;
   
   public class BKingStatueItem extends Sprite implements Disposeable
   {
       
      
      private var _matrixData:Array;
      
      private var _titleName:Bitmap;
      
      private var _spName:Sprite;
      
      private var _lblName:FilterFrameText;
      
      private var _vipName:GradientText;
      
      private var _vipIcon:VipLevelIcon;
      
      private var _attestBtn:ScaleFrameImage;
      
      private var _type:int;
      
      private var _relief:Tile;
      
      private var _info:BKingStatueInfo;
      
      public function BKingStatueItem(param1:int)
      {
         _matrixData = [[7,-6,11,3],[9,-1,41,-1],[6,-13,35,15]];
         super();
         _type = param1;
         if(!int(_type))
         {
            _titleName = ComponentFactory.Instance.creat("asst.hall.attackKing");
            addChild(_titleName);
         }
         if(_titleName)
         {
            _titleName.x = 4;
            _titleName.y = -40;
         }
      }
      
      public function set info(param1:BKingStatueInfo) : void
      {
         _info = param1;
         var _loc2_:PlayerInfo = new PlayerInfo();
         _loc2_.Style = param1.style;
         _loc2_.Colors = param1.color;
         _loc2_.Sex = param1.sex;
         var _loc3_:ShowCharacter = CharactoryFactory.createCharacter(_loc2_) as ShowCharacter;
         _loc3_.addEventListener("complete",__characterComplete);
         _loc3_.showGun = true;
         _loc3_.setShowLight(false,null);
         _loc3_.stopAnimation();
         _loc3_.show(true,1);
      }
      
      private function createName() : void
      {
         var _loc2_:* = null;
         var _loc3_:int = 0;
         var _loc1_:String = _info && _info.name?_info.name:"";
         if(!_spName)
         {
            _spName = new Sprite();
         }
         addChild(_spName);
         if(_info.IsVIP)
         {
            if(!_vipName)
            {
               _vipName = VipController.instance.getVipNameTxt(-1,_info.vipType);
               _vipName.textSize = 16;
               _vipName.text = _loc1_;
            }
            _spName.addChild(_vipName);
            DisplayUtils.removeDisplay(_lblName);
            if(!_vipIcon)
            {
               _vipIcon = new VipLevelIcon();
               if(_info.vipType >= 2)
               {
                  _vipIcon.y = _vipIcon.y - 5;
               }
               _loc2_ = new BasePlayer();
               _loc2_.VIPLevel = _info.vipLevel;
               _loc2_.typeVIP = _info.vipType;
               _vipIcon.setInfo(_loc2_,false);
               _spName.addChild(_vipIcon);
               _vipName.x = _vipIcon.x + _vipIcon.width;
            }
         }
         else
         {
            if(!_lblName)
            {
               _lblName = ComponentFactory.Instance.creat("asset.hall.playerInfo.lblName");
               _lblName.mouseEnabled = false;
               _lblName.text = _loc1_;
            }
            _spName.addChild(_lblName);
            DisplayUtils.removeDisplay(_vipName);
         }
         if(_loc1_ != "")
         {
            _loc3_ = !!_vipIcon?_vipName.width + _vipIcon.width + 8:Number(_lblName.textWidth + 8);
            _spName.graphics.beginFill(0,0.5);
            _spName.graphics.drawRoundRect(-4,0,_loc3_,22,5,5);
            _spName.graphics.endFill();
            _spName.x = (this.width - _spName.width) / 2 - 16;
            _spName.y = 4;
         }
         creatAttestBtn();
      }
      
      private function creatAttestBtn() : void
      {
         if(_info.isAttest)
         {
            _attestBtn = ComponentFactory.Instance.creatComponentByStylename("hall.playerInfo.attest");
            _spName.addChild(_attestBtn);
            if(_info.IsVIP)
            {
               _attestBtn.x = _vipName.x + _vipName.width;
               _attestBtn.y = _vipName.y;
            }
            else
            {
               _attestBtn.x = _lblName.x + _lblName.width;
               _attestBtn.y = _lblName.y;
            }
         }
      }
      
      private function __characterComplete(param1:Event) : void
      {
         var _loc2_:* = null;
         var _loc3_:ShowCharacter = param1.target as ShowCharacter;
         _loc3_.removeEventListener("complete",__characterComplete);
         _loc2_ = new Bitmap(new BitmapData(250,320));
         _loc2_.bitmapData.copyPixels(_loc3_.characterBitmapdata,new Rectangle(0,0,250,320),new Point(0,0));
         _loc2_.scaleX = 0.6;
         _loc2_.scaleY = 0.6;
         _loc2_.smoothing = true;
         addChild(_loc2_);
         ShowRelief(_loc2_);
         createName();
      }
      
      private function ShowRelief(param1:Bitmap) : void
      {
         param1.filters = ComponentFactory.Instance.creatFilters("grayFilter");
         var _loc2_:Bitmap = ComponentFactory.Instance.creat("bombKing.role.relief" + _type);
         _loc2_.blendMode = "hardlight";
         var _loc3_:BitmapData = param1.bitmapData.clone();
         _loc3_.applyFilter(_loc3_,new Rectangle(0,0,param1.width,param1.height),new Point(0,0),new ColorMatrixFilter([0.3,0.59,0.11,0,0,0.3,0.59,0.11,0,0,0.3,0.59,0.11,0,0,0,0,0,1,0]));
         _relief = new Tile(_loc3_,true);
         _relief.scaleX = param1.scaleX;
         _relief.scaleY = param1.scaleY;
         _relief.Dig(new Point(param1.width / 2 + 50,param1.height - 45),null,_loc2_);
         _relief.alpha = 0.4;
         addChild(_relief);
         PositionUtils.setPos(_relief,param1);
      }
      
      public function dispose() : void
      {
         ObjectUtils.disposeObject(_titleName);
         _titleName = null;
         ObjectUtils.disposeObject(_spName);
         _spName = null;
         ObjectUtils.disposeObject(_lblName);
         _lblName = null;
         ObjectUtils.disposeObject(_vipName);
         _vipName = null;
         ObjectUtils.disposeObject(_vipIcon);
         _vipIcon = null;
         ObjectUtils.disposeObject(_attestBtn);
         _attestBtn = null;
      }
   }
}
