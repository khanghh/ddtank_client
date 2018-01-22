package store.view.fusion
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import flash.display.Sprite;
   import store.data.PreviewInfoII;
   
   public class PreviewItem extends Sprite implements Disposeable
   {
       
      
      private var _cell:PreviewItemCell;
      
      private var rate_txt:FilterFrameText;
      
      private var title_txt:FilterFrameText;
      
      public function PreviewItem()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         var _loc1_:MutipleImage = ComponentFactory.Instance.creatComponentByStylename("store.PreviewBG");
         addChild(_loc1_);
         rate_txt = ComponentFactory.Instance.creatComponentByStylename("store.PreviewSuccessRateTxt");
         addChild(rate_txt);
         title_txt = ComponentFactory.Instance.creatComponentByStylename("store.PreviewNameTxt");
         addChild(title_txt);
         _cell = ComponentFactory.Instance.creatCustomObject("store.PreviewItemCell");
         _cell.allowDrag = false;
         addChild(_cell);
      }
      
      public function set info(param1:PreviewInfoII) : void
      {
         _cell.info = param1.info;
         rate_txt.text = param1.rate <= 5?LanguageMgr.GetTranslation("store.fusion.preview.LowRate"):String(param1.rate) + "%";
         title_txt.text = String(param1.info.Name);
      }
      
      public function dispose() : void
      {
         if(_cell)
         {
            ObjectUtils.disposeObject(_cell);
         }
         _cell = null;
         if(rate_txt)
         {
            ObjectUtils.disposeObject(rate_txt);
         }
         rate_txt = null;
         if(title_txt)
         {
            ObjectUtils.disposeObject(title_txt);
         }
         title_txt = null;
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
   }
}
