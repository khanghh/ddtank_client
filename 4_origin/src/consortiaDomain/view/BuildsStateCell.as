package consortiaDomain.view
{
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.utils.ObjectUtils;
   import consortiaDomain.ConsortiaDomainManager;
   import consortiaDomain.EachBuildInfo;
   import ddt.manager.LanguageMgr;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.text.TextField;
   import flash.text.TextFormat;
   import road7th.StarlingMain;
   import starling.scene.consortiaDomain.PlayerView;
   
   public class BuildsStateCell extends Sprite implements Disposeable
   {
       
      
      private var _buildId:int;
      
      private var _tf:TextField;
      
      private var _tfSp:Sprite;
      
      private var _defaultTextFormat:TextFormat;
      
      private var _icon:Image;
      
      private var _state:int = -1;
      
      public function BuildsStateCell(param1:int)
      {
         super();
         _buildId = param1;
         _tfSp = new Sprite();
         addChild(_tfSp);
         _tf = new TextField();
         _tf.autoSize = "left";
         _tf.selectable = false;
         _defaultTextFormat = _tf.defaultTextFormat;
         _defaultTextFormat.font = "Arial";
         _defaultTextFormat.size = 11;
         _defaultTextFormat.bold = true;
         _tf.defaultTextFormat = _defaultTextFormat;
         _tfSp.addChild(_tf);
         _icon = new Image();
         addChild(_icon);
         onChange(null);
         _tfSp.buttonMode = true;
         _tfSp.useHandCursor = true;
         _tfSp.mouseChildren = false;
         _tfSp.addEventListener("click",onClick);
         ConsortiaDomainManager.instance.addEventListener("event_build_in_fight_state_change",onChange);
         ConsortiaDomainManager.instance.addEventListener("event_get_consortia_info_res",onChange);
      }
      
      private function onChange(param1:Event) : void
      {
         var _loc4_:Array = ConsortiaDomainManager.instance.buildNameArr;
         var _loc3_:EachBuildInfo = ConsortiaDomainManager.instance.model.allBuildInfo[_buildId];
         if(_loc3_ == null)
         {
            return;
         }
         var _loc5_:int = ConsortiaDomainManager.instance.getBuildLv(_buildId);
         var _loc6_:String = LanguageMgr.GetTranslation("horse.skillUpFrame.levelTxt",_loc5_);
         var _loc2_:int = _loc3_.State;
         if(_loc2_ == 1)
         {
            _defaultTextFormat.color = 16777215;
            _tf.defaultTextFormat = _defaultTextFormat;
            _tf.text = _loc4_[_buildId] + _loc6_;
            _icon.visible = false;
         }
         else if(_loc2_ == 2)
         {
            _defaultTextFormat.color = 6289152;
            _tf.defaultTextFormat = _defaultTextFormat;
            _tf.text = _loc4_[_buildId] + _loc6_;
            _icon.resourceLink = "consortiadomain.smallIcon.upgrade";
            _icon.visible = true;
         }
         else if(_loc2_ == 3 || _loc2_ == 4)
         {
            _defaultTextFormat.color = 16777215;
            _tf.defaultTextFormat = _defaultTextFormat;
            _tf.text = _loc4_[_buildId] + _loc6_ + "（" + int((ConsortiaDomainManager.instance.consortiaLandRepairBlood - _loc3_.Repair) * 100 / ConsortiaDomainManager.instance.consortiaLandRepairBlood) + "%）";
            _icon.resourceLink = "consortiadomain.smallIcon.repair";
            _icon.visible = true;
         }
         else if(_loc2_ == 6)
         {
            _defaultTextFormat.color = 16590116;
            _tf.defaultTextFormat = _defaultTextFormat;
            _tf.text = _loc4_[_buildId] + _loc6_ + "（" + int(_loc3_.Blood * 100 / ConsortiaDomainManager.instance.consortiaLandBuildBlood) + "%）";
            _icon.resourceLink = "consortiadomain.smallIcon.fight";
            _icon.visible = true;
         }
         else if(_loc2_ == 5)
         {
            _defaultTextFormat.color = 16590116;
            _tf.defaultTextFormat = _defaultTextFormat;
            _tf.text = _loc4_[_buildId] + _loc6_ + "（" + int(_loc3_.Blood * 100 / ConsortiaDomainManager.instance.consortiaLandBuildBlood) + "%）";
            _icon.visible = false;
         }
         _icon.x = _tf.x + _tf.width;
         _icon.y = -1;
      }
      
      private function onClick(param1:MouseEvent) : void
      {
         var _loc3_:Point = ConsortiaDomainManager.BUILD_CENTER_POS_ARR[_buildId];
         var _loc2_:PlayerView = starling.scene.consortiaDomain.ConsortiaDomainScene(StarlingMain.instance.currentScene).playerView;
         _loc2_.checkAndWalkToPoint(_loc3_);
      }
      
      public function dispose() : void
      {
         ConsortiaDomainManager.instance.removeEventListener("event_build_in_fight_state_change",onChange);
         ConsortiaDomainManager.instance.removeEventListener("event_get_consortia_info_res",onChange);
         _tfSp.removeEventListener("click",onClick);
         ObjectUtils.disposeAllChildren(this);
         ObjectUtils.disposeObject(_tf);
         _tf = null;
         ObjectUtils.disposeObject(_icon);
         _icon = null;
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
   }
}
