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
         var topBlack:Sprite = new Sprite();
         topBlack.graphics.beginFill(0);
         topBlack.graphics.drawRect(0,0,1000,100);
         topBlack.graphics.endFill();
         var bottomBlack:Sprite = new Sprite();
         bottomBlack.graphics.beginFill(0);
         bottomBlack.graphics.drawRect(0,0,1000,130);
         bottomBlack.graphics.endFill();
         bottomBlack.y = 470;
         _headImg = ComponentFactory.Instance.creatBitmap("asset.hall.nikeImg");
         _titleTxt = ComponentFactory.Instance.creatComponentByStylename("hall.taskManuGetView.titleTxt");
         _titleTxt.x = 390;
         _titleTxt.y = 488;
         _titleTxt.text = LanguageMgr.GetTranslation("hall.taskManuGetView.titleTxt");
         _descTxt = ComponentFactory.Instance.creatComponentByStylename("hall.guideDialog.contentTxt");
         addChild(topBlack);
         addChild(bottomBlack);
         addChild(_headImg);
         addChild(_titleTxt);
         addChild(_descTxt);
      }
      
      public function show(desc:String, name:String = "", img:Bitmap = null, pos:Point = null) : void
      {
         _descTxt.htmlText = desc;
         if(name != "")
         {
            _titleTxt.text = name + "：";
         }
         else
         {
            _titleTxt.text = LanguageMgr.GetTranslation("hall.taskManuGetView.titleTxt");
         }
         if(_headImg && _headImg.parent)
         {
            _headImg.parent.removeChild(_headImg);
         }
         if(img)
         {
            _headImg = img;
            _headImg.x = pos.x;
            _headImg.y = pos.y;
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
