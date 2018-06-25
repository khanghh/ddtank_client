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
      
      public function BKingStatueItem(type:int)
      {
         _matrixData = [[7,-6,11,3],[9,-1,41,-1],[6,-13,35,15]];
         super();
         _type = type;
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
      
      public function set info(info:BKingStatueInfo) : void
      {
         _info = info;
         var playerInfo:PlayerInfo = new PlayerInfo();
         playerInfo.Style = info.style;
         playerInfo.Colors = info.color;
         playerInfo.Sex = info.sex;
         var characterLoader:ShowCharacter = CharactoryFactory.createCharacter(playerInfo) as ShowCharacter;
         characterLoader.addEventListener("complete",__characterComplete);
         characterLoader.showGun = true;
         characterLoader.setShowLight(false,null);
         characterLoader.stopAnimation();
         characterLoader.show(true,1);
      }
      
      private function createName() : void
      {
         var playerInfo:* = null;
         var spWidth:int = 0;
         var name:String = _info && _info.name?_info.name:"";
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
               _vipName.text = name;
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
               playerInfo = new BasePlayer();
               playerInfo.VIPLevel = _info.vipLevel;
               playerInfo.typeVIP = _info.vipType;
               _vipIcon.setInfo(playerInfo,false);
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
               _lblName.text = name;
            }
            _spName.addChild(_lblName);
            DisplayUtils.removeDisplay(_vipName);
         }
         if(name != "")
         {
            spWidth = !!_vipIcon?_vipName.width + _vipIcon.width + 8:Number(_lblName.textWidth + 8);
            _spName.graphics.beginFill(0,0.5);
            _spName.graphics.drawRoundRect(-4,0,spWidth,22,5,5);
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
      
      private function __characterComplete(event:Event) : void
      {
         var figure:* = null;
         var loader:ShowCharacter = event.target as ShowCharacter;
         loader.removeEventListener("complete",__characterComplete);
         figure = new Bitmap(new BitmapData(250,320));
         figure.bitmapData.copyPixels(loader.characterBitmapdata,new Rectangle(0,0,250,320),new Point(0,0));
         figure.scaleX = 0.6;
         figure.scaleY = 0.6;
         figure.smoothing = true;
         addChild(figure);
         ShowRelief(figure);
         createName();
      }
      
      private function ShowRelief(figure:Bitmap) : void
      {
         figure.filters = ComponentFactory.Instance.creatFilters("grayFilter");
         var reliefBitmap:Bitmap = ComponentFactory.Instance.creat("bombKing.role.relief" + _type);
         reliefBitmap.blendMode = "hardlight";
         var figureData:BitmapData = figure.bitmapData.clone();
         figureData.applyFilter(figureData,new Rectangle(0,0,figure.width,figure.height),new Point(0,0),new ColorMatrixFilter([0.3,0.59,0.11,0,0,0.3,0.59,0.11,0,0,0.3,0.59,0.11,0,0,0,0,0,1,0]));
         _relief = new Tile(figureData,true);
         _relief.scaleX = figure.scaleX;
         _relief.scaleY = figure.scaleY;
         _relief.Dig(new Point(figure.width / 2 + 50,figure.height - 45),null,reliefBitmap);
         _relief.alpha = 0.4;
         addChild(_relief);
         PositionUtils.setPos(_relief,figure);
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
