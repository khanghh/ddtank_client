package pyramid.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   
   public class PyramidHelpView extends Sprite implements Disposeable
   {
       
      
      private var _bg:Bitmap;
      
      private var _panel:ScrollPanel;
      
      private var _list:VBox;
      
      private var _descripTxt:FilterFrameText;
      
      public function PyramidHelpView()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatBitmap("assets.pyramid.helpViewBg");
         addChild(_bg);
         _descripTxt = ComponentFactory.Instance.creatComponentByStylename("assets.pyramid.helpViewScriptTxt");
         _descripTxt.text = LanguageMgr.GetTranslation("ddt.pyramid.helpViewScriptTxt");
         _list = ComponentFactory.Instance.creatComponentByStylename("assets.pyramid.helpViewVBox");
         _list.addChild(_descripTxt);
         _panel = ComponentFactory.Instance.creatComponentByStylename("assets.pyramid.helpViewScrollpanel");
         _panel.setView(_list);
         _panel.invalidateViewport();
         addChild(_panel);
      }
      
      public function dispose() : void
      {
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_descripTxt);
         _descripTxt = null;
         ObjectUtils.disposeAllChildren(_list);
         ObjectUtils.disposeObject(_list);
         _list = null;
         ObjectUtils.disposeAllChildren(_panel);
         ObjectUtils.disposeObject(_panel);
         _panel = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
