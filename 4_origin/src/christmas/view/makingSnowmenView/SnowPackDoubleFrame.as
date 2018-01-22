package christmas.view.makingSnowmenView
{
   import christmas.ChristmasCoreManager;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.SelectedCheckButton;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.vo.AlertInfo;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import ddt.manager.SoundManager;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class SnowPackDoubleFrame extends BaseAlerFrame
   {
       
      
      private var _selectedDoubleCheckButton:SelectedCheckButton;
      
      public var buyFunction:Function;
      
      public var clickFunction:Function;
      
      private var _txt:FilterFrameText;
      
      private var _txtTwo:FilterFrameText;
      
      private var _addNumTxt:FilterFrameText;
      
      private var _inputTxt:FilterFrameText;
      
      private var _maxBnt:BaseButton;
      
      private var _inputPng:Bitmap;
      
      private var _target:Sprite;
      
      private var _isOpen:Boolean;
      
      private var _addDoubleNumTxt:FilterFrameText;
      
      public function SnowPackDoubleFrame()
      {
         super();
         initView();
         initEvents();
      }
      
      public function set target(param1:Sprite) : void
      {
         _target = param1;
      }
      
      private function initView() : void
      {
         var _loc1_:AlertInfo = new AlertInfo(LanguageMgr.GetTranslation("tank.view.task.TaskCatalogContentView.tip"),LanguageMgr.GetTranslation("shop.PresentFrame.OkBtnText"),LanguageMgr.GetTranslation("shop.PresentFrame.CancelBtnText"));
         info = _loc1_;
         _txt = ComponentFactory.Instance.creatComponentByStylename("christmas.alert.txt");
         addToContent(_txt);
      }
      
      public function initAddView(param1:Boolean = false) : void
      {
         _isOpen = param1;
         if(_isOpen)
         {
            _addNumTxt = ComponentFactory.Instance.creatComponentByStylename("christmas.addNum.txt");
            _addNumTxt.text = LanguageMgr.GetTranslation("christmas.addNum.txt.LG");
            _inputTxt = ComponentFactory.Instance.creatComponentByStylename("christmas.input.txt");
            _inputTxt.text = "1";
            _inputPng = ComponentFactory.Instance.creatBitmap("christmas.input.png");
            _maxBnt = ComponentFactory.Instance.creat("christmas.max.Bnt");
            _maxBnt.addEventListener("click",__addMax);
            _selectedDoubleCheckButton = ComponentFactory.Instance.creatComponentByStylename("christmas.makingSnowmen.selectBtn");
            _selectedDoubleCheckButton.selected = false;
            addToContent(_selectedDoubleCheckButton);
            _selectedDoubleCheckButton.addEventListener("click",mouseClickHander);
            _selectedDoubleCheckButton.text = LanguageMgr.GetTranslation("christmas.makingSnowmen.selectedCheckButton.LG");
            _addDoubleNumTxt = ComponentFactory.Instance.creatComponentByStylename("christmas.alert.txtTwo");
            _addDoubleNumTxt.text = LanguageMgr.GetTranslation("christmas.snowpack.doubleMoney",ChristmasCoreManager.instance.model.money);
            addToContent(_addDoubleNumTxt);
            addToContent(_addNumTxt);
            addToContent(_inputPng);
            addToContent(_inputTxt);
            addToContent(_maxBnt);
         }
      }
      
      public function setIsShow(param1:Boolean = true, param2:int = 0) : void
      {
         if(param2 == 0)
         {
            info.showCancel = param1;
         }
      }
      
      private function initEvents() : void
      {
         addEventListener("response",responseHander);
      }
      
      private function __addMax(param1:MouseEvent) : void
      {
         _inputTxt.text = String(ChristmasCoreManager.instance.getCount());
      }
      
      private function mouseClickHander(param1:MouseEvent) : void
      {
         ChristmasCoreManager.instance.model.isSelect = _selectedDoubleCheckButton.selected;
      }
      
      private function removeEvnets() : void
      {
         removeEventListener("response",responseHander);
         if(_selectedDoubleCheckButton)
         {
            _selectedDoubleCheckButton.removeEventListener("click",mouseClickHander);
         }
         if(_maxBnt)
         {
            _maxBnt.removeEventListener("click",__addMax);
         }
      }
      
      private function responseHander(param1:FrameEvent) : void
      {
         SoundManager.instance.playButtonSound();
         if(param1.responseCode == 3 || param1.responseCode == 2)
         {
            if(buyFunction != null && _isOpen)
            {
               buyFunction(int(_inputTxt.text));
               ChristmasCoreManager.instance.model.snowPackNumber = int(_inputTxt.text);
               dispose();
               return;
            }
            if(buyFunction != null)
            {
               buyFunction(ChristmasCoreManager.instance.model.snowPackNumber);
               dispose();
               return;
            }
         }
         else if(param1.responseCode == 0 || param1.responseCode == 1 || param1.responseCode == 4)
         {
            if(_target)
            {
               if(_target is ChristmasMakingSnowmenFrame)
               {
               }
            }
         }
         dispose();
      }
      
      public function setTxt(param1:String) : void
      {
         _txt.htmlText = param1;
      }
      
      override public function dispose() : void
      {
         removeEvnets();
         while(numChildren)
         {
            ObjectUtils.disposeObject(getChildAt(0));
         }
         super.dispose();
         ObjectUtils.disposeAllChildren(this);
         if(_selectedDoubleCheckButton)
         {
            ObjectUtils.disposeObject(_selectedDoubleCheckButton);
         }
         _selectedDoubleCheckButton = null;
      }
   }
}
