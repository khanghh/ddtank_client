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
      
      public function BuildsStateCell(buildId:int)
      {
         super();
         _buildId = buildId;
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
      
      private function onChange(evt:Event) : void
      {
         var buildNameArr:Array = ConsortiaDomainManager.instance.buildNameArr;
         var buildInfo:EachBuildInfo = ConsortiaDomainManager.instance.model.allBuildInfo[_buildId];
         if(buildInfo == null)
         {
            return;
         }
         var buildLv:int = ConsortiaDomainManager.instance.getBuildLv(_buildId);
         var lvStr:String = LanguageMgr.GetTranslation("horse.skillUpFrame.levelTxt",buildLv);
         var buildState:int = buildInfo.State;
         if(buildState == 1)
         {
            _defaultTextFormat.color = 16777215;
            _tf.defaultTextFormat = _defaultTextFormat;
            _tf.text = buildNameArr[_buildId] + lvStr;
            _icon.visible = false;
         }
         else if(buildState == 2)
         {
            _defaultTextFormat.color = 6289152;
            _tf.defaultTextFormat = _defaultTextFormat;
            _tf.text = buildNameArr[_buildId] + lvStr;
            _icon.resourceLink = "consortiadomain.smallIcon.upgrade";
            _icon.visible = true;
         }
         else if(buildState == 3 || buildState == 4)
         {
            _defaultTextFormat.color = 16777215;
            _tf.defaultTextFormat = _defaultTextFormat;
            _tf.text = buildNameArr[_buildId] + lvStr + "（" + int((ConsortiaDomainManager.instance.consortiaLandRepairBlood - buildInfo.Repair) * 100 / ConsortiaDomainManager.instance.consortiaLandRepairBlood) + "%）";
            _icon.resourceLink = "consortiadomain.smallIcon.repair";
            _icon.visible = true;
         }
         else if(buildState == 6)
         {
            _defaultTextFormat.color = 16590116;
            _tf.defaultTextFormat = _defaultTextFormat;
            _tf.text = buildNameArr[_buildId] + lvStr + "（" + int(buildInfo.Blood * 100 / ConsortiaDomainManager.instance.consortiaLandBuildBlood) + "%）";
            _icon.resourceLink = "consortiadomain.smallIcon.fight";
            _icon.visible = true;
         }
         else if(buildState == 5)
         {
            _defaultTextFormat.color = 16590116;
            _tf.defaultTextFormat = _defaultTextFormat;
            _tf.text = buildNameArr[_buildId] + lvStr + "（" + int(buildInfo.Blood * 100 / ConsortiaDomainManager.instance.consortiaLandBuildBlood) + "%）";
            _icon.visible = false;
         }
         _icon.x = _tf.x + _tf.width;
         _icon.y = -1;
      }
      
      private function onClick(evt:MouseEvent) : void
      {
         var buildCenterPoint:Point = ConsortiaDomainManager.BUILD_CENTER_POS_ARR[_buildId];
         var playerView:PlayerView = starling.scene.consortiaDomain.ConsortiaDomainScene(StarlingMain.instance.currentScene).playerView;
         playerView.checkAndWalkToPoint(buildCenterPoint);
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
