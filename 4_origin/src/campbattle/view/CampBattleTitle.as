package campbattle.view
{
   import campbattle.CampBattleControl;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   
   public class CampBattleTitle extends Sprite implements Disposeable
   {
       
      
      private var _backPic:Bitmap;
      
      private var _titleTxt1:FilterFrameText;
      
      private var _titleTxt2:FilterFrameText;
      
      private var _titleTxt3:FilterFrameText;
      
      private var _titleTxt4:FilterFrameText;
      
      public function CampBattleTitle()
      {
         super();
         x = 353;
         y = 35;
         initView();
      }
      
      private function initView() : void
      {
         _backPic = ComponentFactory.Instance.creat("camp.battle.title.back");
         addChild(_backPic);
         _titleTxt1 = ComponentFactory.Instance.creatComponentByStylename("ddtCampBattle.titleTxt1");
         _titleTxt1.text = LanguageMgr.GetTranslation("ddt.campBattle.capturer");
         addChild(_titleTxt1);
         _titleTxt2 = ComponentFactory.Instance.creatComponentByStylename("ddtCampBattle.titleTxt2");
         _titleTxt2.autoSize = "none";
         _titleTxt2.width = 100;
         _titleTxt2.height = 20;
         if(CampBattleControl.instance.model.captureName)
         {
            _titleTxt2.text = CampBattleControl.instance.model.captureName;
         }
         else
         {
            _titleTxt2.text = LanguageMgr.GetTranslation("ddt.campBattle.NOcapture");
         }
         addChild(_titleTxt2);
         _titleTxt3 = ComponentFactory.Instance.creatComponentByStylename("ddtCampBattle.titleTxt3");
         _titleTxt3.text = LanguageMgr.GetTranslation("ddt.campBattle.winCount");
         addChild(_titleTxt3);
         _titleTxt4 = ComponentFactory.Instance.creatComponentByStylename("ddtCampBattle.titleTxt4");
         _titleTxt4.text = CampBattleControl.instance.model.winCount.toString();
         addChild(_titleTxt4);
      }
      
      public function setTitleTxt4(param1:String) : void
      {
         if(param1)
         {
            _titleTxt4.text = param1;
         }
      }
      
      public function setTitleTxt2(param1:String) : void
      {
         if(!param1)
         {
            return;
         }
         _titleTxt2.text = param1;
      }
      
      public function dispose() : void
      {
         while(numChildren)
         {
            ObjectUtils.disposeObject(getChildAt(0));
         }
      }
   }
}
