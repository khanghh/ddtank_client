package gameCommon.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.tip.BaseTip;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Sprite;
   import room.model.WebSpeedInfo;
   
   public class WebSpeedTip extends BaseTip
   {
       
      
      private var _tempData:Object;
      
      private var _bg:ScaleBitmapImage;
      
      private var _stateTxt:FilterFrameText;
      
      private var _delayTxt:FilterFrameText;
      
      private var _fpsTxt:FilterFrameText;
      
      private var _explain1:FilterFrameText;
      
      private var _explain2:FilterFrameText;
      
      private var _container:Sprite;
      
      public function WebSpeedTip()
      {
         super();
      }
      
      override protected function init() : void
      {
         _stateTxt = ComponentFactory.Instance.creatComponentByStylename("game.webSpeed.stateTxt");
         _delayTxt = ComponentFactory.Instance.creatComponentByStylename("game.webSpeed.delayTxt");
         _fpsTxt = ComponentFactory.Instance.creatComponentByStylename("game.webSpeed.fpsTxt");
         _explain1 = ComponentFactory.Instance.creatComponentByStylename("game.webSpeed.explain1Txt");
         _explain2 = ComponentFactory.Instance.creatComponentByStylename("game.webSpeed.explain2Txt");
         _bg = ComponentFactory.Instance.creat("core.GoodsTipBg");
         _container = new Sprite();
         _container.addChild(_stateTxt);
         _container.addChild(_delayTxt);
         _container.addChild(_fpsTxt);
         _container.addChild(_explain1);
         _container.addChild(_explain2);
         super.init();
         this.tipbackgound = _bg;
      }
      
      override protected function addChildren() : void
      {
         super.addChildren();
         addChild(_container);
         _container.mouseEnabled = false;
         _container.mouseChildren = false;
         mouseChildren = false;
         mouseEnabled = false;
      }
      
      override public function get tipData() : Object
      {
         return _tempData;
      }
      
      override public function set tipData(param1:Object) : void
      {
         _tempData = param1;
         if(param1.stateTxt == WebSpeedInfo.BEST)
         {
            _stateTxt.htmlText = "<font color=\'#00FF33\'>" + param1.stateTxt + "</font>";
            _delayTxt.htmlText = "<font color=\'#00FF33\'>" + param1.delayTxt + "</font>";
         }
         else if(param1.stateTxt == WebSpeedInfo.BETTER)
         {
            _stateTxt.htmlText = "<font color=\'#cc9900\'>" + param1.stateTxt + "</font>";
            _delayTxt.htmlText = "<font color=\'#cc9900\'>" + param1.delayTxt + "</font>";
         }
         else if(param1.stateTxt == WebSpeedInfo.WORST)
         {
            _stateTxt.htmlText = "<font color=\'#ff0000\'>" + param1.stateTxt + "</font>";
            _delayTxt.htmlText = "<font color=\'#ff0000\'>" + param1.delayTxt + "</font>";
         }
         _fpsTxt.text = param1.fpsTxt;
         _explain1.text = param1.explain1;
         _explain2.htmlText = param1.explain2;
         drawBG();
      }
      
      private function reset() : void
      {
         _bg.height = 0;
         _bg.width = 0;
      }
      
      private function drawBG(param1:int = 0) : void
      {
         reset();
         if(param1 == 0)
         {
            _bg.width = _container.width + 20;
            _bg.height = _container.height + 10;
         }
         else
         {
            _bg.width = param1 + 2;
            _bg.height = _container.height + 5;
         }
         _width = _bg.width;
         _height = _bg.height;
      }
      
      override public function dispose() : void
      {
         super.dispose();
         if(_stateTxt)
         {
            ObjectUtils.disposeObject(_stateTxt);
         }
         _stateTxt = null;
         if(_delayTxt)
         {
            ObjectUtils.disposeObject(_delayTxt);
         }
         _delayTxt = null;
         if(_fpsTxt)
         {
            ObjectUtils.disposeObject(_fpsTxt);
         }
         _fpsTxt = null;
         if(_explain1)
         {
            ObjectUtils.disposeObject(_explain1);
         }
         _explain1 = null;
         if(_explain2)
         {
            ObjectUtils.disposeObject(_explain2);
         }
         _explain2 = null;
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
   }
}
