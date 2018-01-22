package ddt.view.buff.buffButton
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import ddt.manager.LanguageMgr;
   import ddt.utils.PositionUtils;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class GrowHelpTipView extends Sprite
   {
      
      private static const BTNNUM:int = 5;
       
      
      private var _viewBg:ScaleBitmapImage;
      
      private var _buffArray:Vector.<BuffButton>;
      
      private var _openBtn:Vector.<TextButton>;
      
      public function GrowHelpTipView()
      {
         super();
         initData();
         initView();
      }
      
      private function initData() : void
      {
         _buffArray = new Vector.<BuffButton>();
         _openBtn = new Vector.<TextButton>();
      }
      
      private function initView() : void
      {
         _viewBg = ComponentFactory.Instance.creatComponentByStylename("bagBuffer.tipView.bg");
         addChild(_viewBg);
      }
      
      private function addOpenButton() : void
      {
         var _loc1_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < 5)
         {
            _openBtn.push(ComponentFactory.Instance.creatComponentByStylename("bagBuffer.growHelp.openBtn"));
            _openBtn[_loc1_].text = LanguageMgr.GetTranslation("ddt.bagandinfo.buffBuf");
            _openBtn[_loc1_].addEventListener("click",__onClick);
            PositionUtils.setPos(_openBtn[_loc1_],"growhelp.buffPos" + (String(_loc1_ + 1)));
            _openBtn[_loc1_].x = _openBtn[_loc1_].x + 50;
            _openBtn[_loc1_].y = _openBtn[_loc1_].y - 4;
            addChild(_openBtn[_loc1_]);
            PositionUtils.setPos(_buffArray[_loc1_],"growhelp.buffPos" + (String(_loc1_ + 1)));
            _loc1_++;
         }
      }
      
      protected function __onClick(param1:MouseEvent) : void
      {
         var _loc3_:int = 0;
         var _loc2_:int = _openBtn.length;
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            if(_openBtn[_loc3_] == param1.currentTarget)
            {
               _buffArray[_loc3_].dispatchEvent(new MouseEvent("click"));
               break;
            }
            _loc3_++;
         }
      }
      
      public function addBuff(param1:Array) : void
      {
         var _loc3_:int = 0;
         var _loc2_:int = param1.length;
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            _buffArray.push(param1[_loc3_]);
            addChild(param1[_loc3_]);
            _loc3_++;
         }
         addOpenButton();
      }
      
      public function dispose() : void
      {
         var _loc2_:int = 0;
         var _loc1_:int = 0;
         if(_viewBg)
         {
            _viewBg.dispose();
            _viewBg = null;
         }
         _loc2_ = 0;
         while(_loc2_ < _buffArray.length)
         {
            _buffArray[_loc2_].dispose();
            _buffArray[_loc2_] = null;
            _loc2_++;
         }
         _buffArray = null;
         _loc1_ = 0;
         while(_loc1_ < _openBtn.length)
         {
            _openBtn[_loc1_].dispose();
            _openBtn[_loc1_] = null;
            _loc1_++;
         }
         _openBtn = null;
      }
      
      public function get viewBg() : ScaleBitmapImage
      {
         return _viewBg;
      }
   }
}
