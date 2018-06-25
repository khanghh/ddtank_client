package dayActivity.items
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   
   public class DayActivieTitle extends Sprite implements Disposeable
   {
       
      
      private var _bg:MovieClip;
      
      private var _txt1:FilterFrameText;
      
      private var _txt2:FilterFrameText;
      
      private var _txt3:FilterFrameText;
      
      private var _txt4:FilterFrameText;
      
      public function DayActivieTitle()
      {
         super();
         init();
      }
      
      private function init() : void
      {
         _bg = ComponentFactory.Instance.creat("asset.activity.menberList.bg");
         _bg.width = 720;
         _bg.height = 375;
         _bg.x = 27;
         _bg.y = 92;
         addChild(_bg);
         _txt1 = ComponentFactory.Instance.creatComponentByStylename("day.activieView.title.itemTxt");
         _txt1.text = LanguageMgr.GetTranslation("ddt.dayActivity.activityName");
         _txt1.x = 50;
         _txt1.y = 102;
         addChild(_txt1);
         _txt2 = ComponentFactory.Instance.creatComponentByStylename("day.activieView.title.itemTxt");
         _txt2.text = LanguageMgr.GetTranslation("ddt.dayActivity.activitytime");
         _txt2.x = 189;
         _txt2.y = 100;
         addChild(_txt2);
         _txt3 = ComponentFactory.Instance.creatComponentByStylename("day.activieView.title.itemTxt");
         _txt3.text = LanguageMgr.GetTranslation("ddt.dayActivity.activityNum");
         _txt3.x = 330;
         _txt3.y = 100;
         addChild(_txt3);
         _txt4 = ComponentFactory.Instance.creatComponentByStylename("day.activieView.title.itemTxt");
         _txt4.text = LanguageMgr.GetTranslation("ddt.dayActivity.activityOpen");
         _txt4.x = 494;
         _txt4.y = 100;
         addChild(_txt4);
         var line1:Bitmap = ComponentFactory.Instance.creatBitmap("asset.corel.formLineBig");
         line1.x = 140;
         line1.y = 93;
         addChild(line1);
         var line2:Bitmap = ComponentFactory.Instance.creatBitmap("asset.corel.formLineBig");
         line2.x = 300;
         line2.y = 93;
         addChild(line2);
         var line3:Bitmap = ComponentFactory.Instance.creatBitmap("asset.corel.formLineBig");
         line3.x = 430;
         line3.y = 93;
         addChild(line3);
         var line4:Bitmap = ComponentFactory.Instance.creatBitmap("asset.corel.formLineBig");
         line4.x = 620;
         line4.y = 93;
         addChild(line4);
      }
      
      public function dispose() : void
      {
         while(numChildren)
         {
            ObjectUtils.disposeObject(getChildAt(0));
         }
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
