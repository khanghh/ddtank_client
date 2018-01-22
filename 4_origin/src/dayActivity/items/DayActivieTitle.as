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
         var _loc2_:Bitmap = ComponentFactory.Instance.creatBitmap("asset.corel.formLineBig");
         _loc2_.x = 140;
         _loc2_.y = 93;
         addChild(_loc2_);
         var _loc4_:Bitmap = ComponentFactory.Instance.creatBitmap("asset.corel.formLineBig");
         _loc4_.x = 300;
         _loc4_.y = 93;
         addChild(_loc4_);
         var _loc3_:Bitmap = ComponentFactory.Instance.creatBitmap("asset.corel.formLineBig");
         _loc3_.x = 430;
         _loc3_.y = 93;
         addChild(_loc3_);
         var _loc1_:Bitmap = ComponentFactory.Instance.creatBitmap("asset.corel.formLineBig");
         _loc1_.x = 620;
         _loc1_.y = 93;
         addChild(_loc1_);
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
