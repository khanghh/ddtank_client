package consortion.view.selfConsortia
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.MovieImage;
   import com.pickgliss.utils.ObjectUtils;
   import consortion.ConsortionModelManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.utils.PositionUtils;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class SelfConsortiaView extends Sprite implements Disposeable
   {
       
      
      private var _BG:MovieImage;
      
      private var _infoView:ConsortionInfoView;
      
      private var _memberList:MemberList;
      
      private var _placardAndEvent:PlacardAndEvent;
      
      private var _buildingManager:BuildingManager;
      
      private var _DissolveConsortia:TextButton;
      
      public function SelfConsortiaView()
      {
         super();
      }
      
      public function enterSelfConsortion() : void
      {
         ConsortionModelManager.Instance.getConsortionMember(ConsortionModelManager.Instance.memberListComplete);
         ConsortionModelManager.Instance.getConsortionList(ConsortionModelManager.Instance.selfConsortionComplete,1,6,"",-1,-1,-1,PlayerManager.Instance.Self.ConsortiaID);
         init();
         initEvent();
      }
      
      private function init() : void
      {
         trace("SelfConsortiaView");
         _DissolveConsortia = ComponentFactory.Instance.creat("DissolveConsortia");
         _DissolveConsortia.text = LanguageMgr.GetTranslation("dismiss");
         _BG = ComponentFactory.Instance.creatComponentByStylename("consortion.BG");
         _infoView = ComponentFactory.Instance.creatCustomObject("consortionInfoView");
         PositionUtils.setPos(_infoView,"consortion.consortionInfoView.pos");
         _memberList = ComponentFactory.Instance.creatCustomObject("memberList");
         PositionUtils.setPos(_memberList,"consortion.memberList.pos");
         _placardAndEvent = ComponentFactory.Instance.creatCustomObject("placardAndEvent");
         PositionUtils.setPos(_placardAndEvent,"consortion.placardAndEvent.pos");
         _buildingManager = ComponentFactory.Instance.creatCustomObject("buildingManager");
         PositionUtils.setPos(_buildingManager,"consortion.buildingManager.pos");
         addChild(_BG);
         addChild(_infoView);
         addChild(_memberList);
         addChild(_placardAndEvent);
         addChild(_buildingManager);
      }
      
      private function initEvent() : void
      {
      }
      
      private function __dissolve(param1:MouseEvent) : void
      {
         SocketManager.Instance.out.sendConsortiaDismiss();
      }
      
      private function removeEvent() : void
      {
      }
      
      public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeAllChildren(this);
         if(_BG)
         {
            ObjectUtils.disposeObject(_BG);
         }
         if(_infoView)
         {
            ObjectUtils.disposeObject(_infoView);
         }
         if(_memberList)
         {
            ObjectUtils.disposeObject(_memberList);
         }
         if(_placardAndEvent)
         {
            ObjectUtils.disposeObject(_placardAndEvent);
         }
         if(_buildingManager)
         {
            ObjectUtils.disposeObject(_buildingManager);
         }
         if(_DissolveConsortia)
         {
            ObjectUtils.disposeObject(_DissolveConsortia);
         }
         _BG = null;
         _infoView = null;
         _memberList = null;
         _placardAndEvent = null;
         _buildingManager = null;
         _DissolveConsortia = null;
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
   }
}
