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
         var i:int = 0;
         for(i = 0; i < 5; )
         {
            _openBtn.push(ComponentFactory.Instance.creatComponentByStylename("bagBuffer.growHelp.openBtn"));
            _openBtn[i].text = LanguageMgr.GetTranslation("ddt.bagandinfo.buffBuf");
            _openBtn[i].addEventListener("click",__onClick);
            PositionUtils.setPos(_openBtn[i],"growhelp.buffPos" + (String(i + 1)));
            _openBtn[i].x = _openBtn[i].x + 50;
            _openBtn[i].y = _openBtn[i].y - 4;
            addChild(_openBtn[i]);
            PositionUtils.setPos(_buffArray[i],"growhelp.buffPos" + (String(i + 1)));
            i++;
         }
      }
      
      protected function __onClick(event:MouseEvent) : void
      {
         var i:int = 0;
         var length:int = _openBtn.length;
         for(i = 0; i < length; )
         {
            if(_openBtn[i] == event.currentTarget)
            {
               _buffArray[i].dispatchEvent(new MouseEvent("click"));
               break;
            }
            i++;
         }
      }
      
      public function addBuff(buffArray:Array) : void
      {
         var i:int = 0;
         var length:int = buffArray.length;
         for(i = 0; i < length; )
         {
            _buffArray.push(buffArray[i]);
            addChild(buffArray[i]);
            i++;
         }
         addOpenButton();
      }
      
      public function dispose() : void
      {
         var i:int = 0;
         var j:int = 0;
         if(_viewBg)
         {
            _viewBg.dispose();
            _viewBg = null;
         }
         i = 0;
         while(i < _buffArray.length)
         {
            _buffArray[i].dispose();
            _buffArray[i] = null;
            i++;
         }
         _buffArray = null;
         for(j = 0; j < _openBtn.length; )
         {
            _openBtn[j].dispose();
            _openBtn[j] = null;
            j++;
         }
         _openBtn = null;
      }
      
      public function get viewBg() : ScaleBitmapImage
      {
         return _viewBg;
      }
   }
}
