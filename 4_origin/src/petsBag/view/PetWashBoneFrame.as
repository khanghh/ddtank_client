package petsBag.view
{
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import ddt.manager.SoundManager;
   import flash.events.MouseEvent;
   
   public class PetWashBoneFrame extends Frame
   {
       
      
      private var _view:PetWashBoneView;
      
      public function PetWashBoneFrame()
      {
         super();
      }
      
      override protected function init() : void
      {
         _view = new PetWashBoneView();
         super.init();
         titleText = LanguageMgr.GetTranslation("ddt.pets.washBone.titleName");
      }
      
      override protected function addChildren() : void
      {
         super.addChildren();
         addChild(_view);
      }
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,3,true,1);
      }
      
      override protected function __onCloseClick(event:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         super.__onCloseClick(event);
         dispose();
      }
      
      override public function dispose() : void
      {
         ObjectUtils.disposeObject(_view);
         _view = null;
         super.dispose();
      }
   }
}
