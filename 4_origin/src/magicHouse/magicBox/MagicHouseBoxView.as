package magicHouse.magicBox
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.SelectedButtonGroup;
   import com.pickgliss.ui.controls.SelectedTextButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.Event;
   
   public class MagicHouseBoxView extends Sprite implements Disposeable
   {
       
      
      private var _bg:Bitmap;
      
      private var _extractionBtn:SelectedTextButton;
      
      private var _fusionBtn:SelectedTextButton;
      
      private var _btnGroup:SelectedButtonGroup;
      
      private var _extractionView:MagicHouseExtraction;
      
      private var _fusionView:MagicHouseFusionView;
      
      public function MagicHouseBoxView()
      {
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatBitmap("magichouse.magicboxview.mainview.bg");
         addChild(_bg);
         _extractionBtn = ComponentFactory.Instance.creatComponentByStylename("maigchouse.magicboxview.extractionBtn");
         _extractionBtn.text = LanguageMgr.GetTranslation("magichouse.magicboxView.extractiontxt");
         addChild(_extractionBtn);
         _fusionBtn = ComponentFactory.Instance.creatComponentByStylename("maigchouse.magicboxview.fusionBtn");
         _fusionBtn.text = LanguageMgr.GetTranslation("magichouse.magicboxView.fusiontxt");
         addChild(_fusionBtn);
         _btnGroup = new SelectedButtonGroup();
         _btnGroup.addSelectItem(_extractionBtn);
         _btnGroup.addSelectItem(_fusionBtn);
         _btnGroup.selectIndex = 0;
         _createExtractionView();
      }
      
      private function initEvent() : void
      {
         _btnGroup.addEventListener("change",__changeHandler);
      }
      
      private function removeEvent() : void
      {
         _btnGroup.removeEventListener("change",__changeHandler);
      }
      
      private function __changeHandler(param1:Event) : void
      {
         switch(int(_btnGroup.selectIndex))
         {
            case 0:
               if(!_extractionView)
               {
                  _extractionView = ComponentFactory.Instance.creatCustomObject("magicHouse.magicBoxMainView.extractionview");
                  addChild(_extractionView);
               }
               _extractionView.visible = true;
               if(_fusionView)
               {
                  _fusionView.visible = false;
               }
               break;
            case 1:
               if(!_fusionView)
               {
                  _fusionView = ComponentFactory.Instance.creatCustomObject("magicHouse.magicBoxMainView.fusionview");
                  addChild(_fusionView);
               }
               _fusionView.visible = true;
               if(_extractionView)
               {
                  _extractionView.visible = false;
                  break;
               }
         }
      }
      
      private function _createExtractionView() : void
      {
         if(!_extractionView)
         {
            _extractionView = ComponentFactory.Instance.creatCustomObject("magicHouse.magicBoxMainView.extractionview");
            addChild(_extractionView);
         }
      }
      
      public function dispose() : void
      {
         removeEvent();
         if(_bg)
         {
            ObjectUtils.disposeObject(_bg);
         }
         _bg = null;
         if(_extractionBtn)
         {
            ObjectUtils.disposeObject(_extractionBtn);
         }
         _extractionBtn = null;
         if(_fusionBtn)
         {
            ObjectUtils.disposeObject(_fusionBtn);
         }
         _fusionBtn = null;
         if(_fusionView)
         {
            ObjectUtils.disposeObject(_fusionView);
         }
         _fusionView = null;
         if(_extractionView)
         {
            ObjectUtils.disposeObject(_extractionView);
         }
         _extractionView = null;
      }
   }
}
