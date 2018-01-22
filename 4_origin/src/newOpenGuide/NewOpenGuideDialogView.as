package newOpenGuide
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.geom.Point;
   
   public class NewOpenGuideDialogView extends Sprite implements Disposeable
   {
       
      
      private var _headImg:Bitmap;
      
      private var _titleTxt:FilterFrameText;
      
      private var _descTxt:FilterFrameText;
      
      public function NewOpenGuideDialogView()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         this.graphics.beginFill(0,0.4);
         this.graphics.drawRect(0,0,1000,600);
         this.graphics.endFill();
         var _loc2_:Sprite = new Sprite();
         _loc2_.graphics.beginFill(0);
         _loc2_.graphics.drawRect(0,0,1000,100);
         _loc2_.graphics.endFill();
         var _loc1_:Sprite = new Sprite();
         _loc1_.graphics.beginFill(0);
         _loc1_.graphics.drawRect(0,0,1000,130);
         _loc1_.graphics.endFill();
         _loc1_.y = 470;
         _headImg = ComponentFactory.Instance.creatBitmap("asset.hall.nikeImg");
         _titleTxt = ComponentFactory.Instance.creatComponentByStylename("hall.taskManuGetView.titleTxt");
         _titleTxt.x = 390;
         _titleTxt.y = 488;
         _titleTxt.text = LanguageMgr.GetTranslation("hall.taskManuGetView.titleTxt");
         _descTxt = ComponentFactory.Instance.creatComponentByStylename("hall.guideDialog.contentTxt");
         addChild(_loc2_);
         addChild(_loc1_);
         addChild(_headImg);
         addChild(_titleTxt);
         addChild(_descTxt);
      }
      
      public function show(param1:String, param2:String = "", param3:Bitmap = null, param4:Point = null) : void
      {
         _descTxt.htmlText = param1;
         if(param2 != "")
         {
            _titleTxt.text = param2 + "：";
         }
         else
         {
            _titleTxt.text = LanguageMgr.GetTranslation("hall.taskManuGetView.titleTxt");
         }
         if(_headImg && _headImg.parent)
         {
            _headImg.parent.removeChild(_headImg);
         }
         if(param3)
         {
            _headImg = param3;
            _headImg.x = param4.x;
            _headImg.y = param4.y;
         }
         else
         {
            _headImg = ComponentFactory.Instance.creatBitmap("asset.hall.nikeImg");
            _headImg.x = 116;
            _headImg.y = 313;
         }
         addChild(_headImg);
      }
      
      public function dispose() : void
      {
         ObjectUtils.disposeAllChildren(this);
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
