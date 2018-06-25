package wasteRecycle.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.manager.ItemManager;
   import ddt.manager.LanguageMgr;
   import flash.display.Sprite;
   import wasteRecycle.WasteRecycleController;
   
   public class WasteRecycleHelperFrame extends Frame
   {
       
      
      private var _helptext:FilterFrameText;
      
      private var _bg:Scale9CornerImage;
      
      private var _scrollPanel:ScrollPanel;
      
      private var _helptext2:FilterFrameText;
      
      private var _infoList:Array;
      
      private var _sprite:Sprite;
      
      private var _helptext3:FilterFrameText;
      
      public function WasteRecycleHelperFrame()
      {
         super();
      }
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,3,true,1);
      }
      
      override protected function init() : void
      {
         _bg = ComponentFactory.Instance.creatComponentByStylename("wasteRecycle.helperFrameBg");
         _scrollPanel = ComponentFactory.Instance.creatComponentByStylename("wasteRecycle.helperFrame.List");
         _helptext = ComponentFactory.Instance.creatComponentByStylename("wasteRecycle.helpFramText");
         _helptext.htmlText = LanguageMgr.GetTranslation("WasteRecycleHelperFrame.descriptionMsg");
         _helptext2 = ComponentFactory.Instance.creatComponentByStylename("wasteRecycle.helpFramText2");
         _helptext3 = ComponentFactory.Instance.creatComponentByStylename("wasteRecycle.helpFramText3");
         _sprite = new Sprite();
         _sprite.addChild(_helptext);
         _sprite.addChild(_helptext2);
         _sprite.addChild(_helptext3);
         _scrollPanel.setView(_sprite);
         super.init();
         updataView();
         titleText = LanguageMgr.GetTranslation("store.view.HelpButtonText");
      }
      
      override protected function addChildren() : void
      {
         super.addChildren();
         if(_bg)
         {
            addToContent(_bg);
         }
         if(_scrollPanel)
         {
            addToContent(_scrollPanel);
         }
      }
      
      override protected function onFrameClose() : void
      {
         this.dispose();
      }
      
      private function updataView() : void
      {
         var i:int = 0;
         var info:* = null;
         _infoList = WasteRecycleController.instance.model.data.list;
         for(i = 0; i < _infoList.length; )
         {
            info = ItemManager.fillByID(_infoList[i].TemplateID);
            _helptext2.text = _helptext2.text + (info.Name + "\n");
            _helptext3.text = _helptext3.text + (_infoList[i].Integral + "\n");
            i++;
         }
         _scrollPanel.invalidateViewport();
      }
      
      override public function dispose() : void
      {
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_scrollPanel);
         _scrollPanel = null;
         ObjectUtils.disposeObject(_sprite);
         _sprite = null;
         ObjectUtils.disposeObject(_helptext);
         _helptext = null;
         ObjectUtils.disposeObject(_helptext2);
         _helptext2 = null;
         ObjectUtils.disposeObject(_helptext3);
         _helptext3 = null;
         super.dispose();
      }
   }
}
