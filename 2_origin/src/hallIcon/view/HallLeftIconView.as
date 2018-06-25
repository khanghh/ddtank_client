package hallIcon.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ClassUtils;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import ddt.manager.SoundManager;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import hallIcon.HallIconManager;
   import hallIcon.event.HallIconEvent;
   import hallIcon.info.HallIconInfo;
   import kingBless.KingBlessManager;
   import vip.VipController;
   
   public class HallLeftIconView extends Sprite implements Disposeable
   {
       
      
      private var _iconVBox:VBox;
      
      private var _expblessedIcon:Component;
      
      private var _vipLvlIcon:MovieClip;
      
      private var _kingBlessIcon:Component;
      
      public function HallLeftIconView()
      {
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         _iconVBox = new VBox();
         _iconVBox.spacing = 5;
         addChild(_iconVBox);
         updateExpblessedIcon();
         updateVipLvlIcon();
         updateKingBlessIcon();
      }
      
      private function initEvent() : void
      {
         HallIconManager.instance.model.addEventListener("updateLeftIconView",__updateLeftIconView);
      }
      
      private function addChildBox($child:DisplayObject) : void
      {
         _iconVBox.addChild($child);
         _iconVBox.arrange();
      }
      
      private function updateExpblessedIcon() : void
      {
         if(HallIconManager.instance.model.expblessedIsOpen)
         {
            if(_expblessedIcon == null)
            {
               _expblessedIcon = createComponentIcon("assets.hallIcon.expblessedIcon");
               _expblessedIcon.buttonMode = true;
               addChildBox(_expblessedIcon);
            }
            _expblessedIcon.tipData = LanguageMgr.GetTranslation("ddt.HallStateView.expValue",HallIconManager.instance.model.expblessedValue);
         }
         else
         {
            removeExpblessedIcon();
         }
      }
      
      private function __updateLeftIconView(evt:HallIconEvent) : void
      {
         var hallIconInfo:HallIconInfo = evt.data as HallIconInfo;
         var _loc3_:* = hallIconInfo.icontype;
         if("expblessed" !== _loc3_)
         {
            if("viplvl" === _loc3_)
            {
               updateVipLvlIcon();
            }
         }
         else
         {
            updateExpblessedIcon();
         }
      }
      
      private function updateVipLvlIcon() : void
      {
         if(HallIconManager.instance.model.vipLvlIsOpen)
         {
            if(_vipLvlIcon == null)
            {
               _vipLvlIcon = ClassUtils.CreatInstance("assets.hallIcon.VIPLvlIcon");
               _vipLvlIcon.buttonMode = true;
               _vipLvlIcon.addEventListener("click",__vipLvlIconClickHandler);
               addChildBox(_vipLvlIcon);
            }
         }
         else
         {
            removeVipLvlIcon();
         }
      }
      
      private function __vipLvlIconClickHandler(evt:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         VipController.instance.show();
      }
      
      private function updateKingBlessIcon() : void
      {
         if(HallIconManager.instance.model.kingBlessIsOpen)
         {
            if(_kingBlessIcon == null)
            {
               _kingBlessIcon = createComponentIcon("assets.hallIcon.kingBlessIcon");
               _kingBlessIcon.buttonMode = true;
               _kingBlessIcon.addEventListener("click",__kingBlessIconClickHandler);
               addChildBox(_kingBlessIcon);
            }
            _kingBlessIcon.tipStyle = "ddt.view.tips.KingBlessTip";
            _kingBlessIcon.tipData = KingBlessManager.instance.getRemainTimeTxt();
         }
         else
         {
            removeKingBlessIcon();
         }
      }
      
      private function __kingBlessIconClickHandler(evt:MouseEvent) : void
      {
         SoundManager.instance.play("008");
      }
      
      private function createComponentIcon($iconString:String) : Component
      {
         var tempComponent:Component = new Component();
         tempComponent.tipStyle = "ddt.view.tips.OneLineTip";
         tempComponent.tipDirctions = "7,3,6";
         tempComponent.addChild(ComponentFactory.Instance.creat($iconString));
         tempComponent.width = 70;
         tempComponent.height = 70;
         return tempComponent;
      }
      
      private function removeEvent() : void
      {
         HallIconManager.instance.model.removeEventListener("updateLeftIconView",__updateLeftIconView);
      }
      
      private function removeVipLvlIcon() : void
      {
         if(_vipLvlIcon)
         {
            _vipLvlIcon.removeEventListener("click",__vipLvlIconClickHandler);
            _vipLvlIcon.stop();
            ObjectUtils.disposeObject(_vipLvlIcon);
            _vipLvlIcon = null;
         }
      }
      
      private function removeExpblessedIcon() : void
      {
         if(_expblessedIcon)
         {
            ObjectUtils.disposeAllChildren(_expblessedIcon);
            ObjectUtils.disposeObject(_expblessedIcon);
            _expblessedIcon = null;
         }
      }
      
      private function removeKingBlessIcon() : void
      {
         if(_kingBlessIcon)
         {
            _kingBlessIcon.removeEventListener("click",__kingBlessIconClickHandler);
            ObjectUtils.disposeAllChildren(_kingBlessIcon);
            ObjectUtils.disposeObject(_kingBlessIcon);
            _kingBlessIcon = null;
         }
      }
      
      public function dispose() : void
      {
         removeEvent();
         removeExpblessedIcon();
         removeVipLvlIcon();
         removeKingBlessIcon();
         if(_iconVBox)
         {
            ObjectUtils.disposeAllChildren(_iconVBox);
            ObjectUtils.disposeObject(_iconVBox);
            _iconVBox = null;
         }
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
