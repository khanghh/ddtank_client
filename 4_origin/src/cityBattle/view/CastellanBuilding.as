package cityBattle.view
{
   import cityBattle.CityBattleManager;
   import cityBattle.data.CastellanInfo;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ClassUtils;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import ddt.utils.PositionUtils;
   import ddt.view.character.CharactoryFactory;
   import ddt.view.character.RoomCharacter;
   import ddt.view.tips.OneLineTip;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class CastellanBuilding extends Sprite implements Disposeable
   {
       
      
      private var building:MovieClip;
      
      private var control:MovieClip;
      
      private var _character:RoomCharacter;
      
      private var _tip:OneLineTip;
      
      private var _cityName:Bitmap;
      
      public function CastellanBuilding(type:int)
      {
         super();
         var info:CastellanInfo = CityBattleManager.instance.castellanList[type - 1];
         building = ClassUtils.CreatInstance("asset.cityBattle.building" + String(type));
         addChild(building);
         if(type == CityBattleManager.instance.now)
         {
            building.gotoAndStop(2);
         }
         else
         {
            building.gotoAndStop(1);
         }
         control = ClassUtils.CreatInstance("asset.cityBattle.control");
         addChild(control);
         PositionUtils.setPos(control,"castellan.control" + String(type) + "Pos");
         control.gotoAndStop(info.side + 1);
         _cityName = ComponentFactory.Instance.creatBitmap("asset.cityBattle.buildingName" + String(type));
         addChild(_cityName);
         if(info.winner)
         {
            _character = CharactoryFactory.createCharacter(info.winner,"room") as RoomCharacter;
            _character.showGun = false;
            _character.show(false,-1);
            addChild(_character);
            PositionUtils.setPos(_character,"castellan.character" + String(type) + "Pos");
            _character.mouseEnabled = true;
            _character.addEventListener("mouseOver",overHandler);
            _character.addEventListener("mouseOut",outHandler);
            _tip = new OneLineTip();
            _tip.tipData = LanguageMgr.GetTranslation("ddt.cityBattle.winnerInfo.tips",info.winner.NickName,info.winner.zoneName,info.winner.Grade);
            _tip.x = _character.x;
            _tip.visible = false;
            addChild(_tip);
         }
      }
      
      private function overHandler(e:MouseEvent) : void
      {
         _tip.visible = true;
      }
      
      private function outHandler(e:MouseEvent) : void
      {
         _tip.visible = false;
      }
      
      public function dispose() : void
      {
         if(_character)
         {
            _character.removeEventListener("mouseOver",overHandler);
            _character.removeEventListener("mouseOut",outHandler);
         }
         ObjectUtils.disposeObject(_tip);
         _tip = null;
         ObjectUtils.disposeObject(building);
         building = null;
         ObjectUtils.disposeObject(_cityName);
         _cityName = null;
         ObjectUtils.disposeObject(control);
         control = null;
         ObjectUtils.disposeObject(_character);
         _character = null;
      }
   }
}
