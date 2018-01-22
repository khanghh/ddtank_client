package moneyTree.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import ddt.manager.SoundManager;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.utils.setTimeout;
   import moneyTree.MoneyTreeController;
   import moneyTree.MoneyTreeManager;
   
   public class CountDownBoard extends Sprite implements Disposeable
   {
       
      
      private var _index:int;
      
      private var _bg:Bitmap;
      
      private var _title:Bitmap;
      
      private var _speedUpBtn:SimpleBitmapButton;
      
      private var _countDownTextField:FilterFrameText;
      
      public function CountDownBoard(param1:int, param2:Bitmap)
      {
         _index = param1;
         super();
         _bg = ComponentFactory.Instance.creatBitmap("moneyTree.cd.bg");
         addChild(_bg);
         _title = param2;
         _title.x = -1;
         _title.y = 2;
         addChild(_title);
         _speedUpBtn = ComponentFactory.Instance.creat("moneyTree.speedup.Btn");
         _speedUpBtn.addEventListener("click",onSpeedUpClick);
         addChild(_speedUpBtn);
         _countDownTextField = ComponentFactory.Instance.creat("moneyTree.cd.textField");
         addChild(_countDownTextField);
      }
      
      protected function onSpeedUpClick(param1:MouseEvent) : void
      {
         _speedUpBtn.enable = false;
         SoundManager.instance.play("008");
         MoneyTreeManager.getInstance().onSpeedUpClick(_index);
      }
      
      private function setBtnEnable() : void
      {
         if(_speedUpBtn)
         {
            _speedUpBtn.enable = true;
         }
      }
      
      public function updateTime(param1:String) : void
      {
         _countDownTextField.text = param1;
         if(param1 == LanguageMgr.GetTranslation("moneyTree.MoneyTreeModel.TreeOK"))
         {
            _speedUpBtn.visible = false;
            MoneyTreeController.getInstance().BecomeMature();
         }
         else
         {
            _speedUpBtn.visible = true;
         }
      }
      
      public function dispose() : void
      {
         if(_bg != null)
         {
            ObjectUtils.disposeObject(_bg);
            _bg = null;
         }
         if(_title != null)
         {
            ObjectUtils.disposeObject(_title);
            _title = null;
         }
         if(_speedUpBtn != null)
         {
            _speedUpBtn.removeEventListener("click",onSpeedUpClick);
            ObjectUtils.disposeObject(_speedUpBtn);
            _speedUpBtn = null;
         }
         if(_countDownTextField != null)
         {
            ObjectUtils.disposeObject(_countDownTextField);
            _countDownTextField = null;
         }
      }
   }
}
