package homeTemple.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   
   public class HomeTempleBlessItem extends Sprite implements Disposeable
   {
       
      
      private var _id:int;
      
      private var _bless:MovieClip;
      
      private var _blessBtn:BaseButton;
      
      public function HomeTempleBlessItem(param1:int)
      {
         super();
         _id = param1;
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         _bless = ComponentFactory.Instance.creat("asset.home.temple.a00" + (_id + 1).toString());
         addChild(_bless);
         _blessBtn = ComponentFactory.Instance.creatComponentByStylename("home.temple.circleTipBtn");
         _blessBtn.tipData = LanguageMgr.GetTranslation("home.temple.circleTipText" + _id);
         addChild(_blessBtn);
      }
      
      private function initEvent() : void
      {
      }
      
      private function removeEvent() : void
      {
      }
      
      public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_bless);
         _bless = null;
         ObjectUtils.disposeObject(_blessBtn);
         _blessBtn = null;
      }
      
      public function get blessBtn() : BaseButton
      {
         return _blessBtn;
      }
      
      public function get blessMovie() : MovieClip
      {
         return _bless;
      }
   }
}
