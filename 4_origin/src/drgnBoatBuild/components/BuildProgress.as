package drgnBoatBuild.components
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import ddt.utils.PositionUtils;
   import ddt.view.tips.OneLineTip;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class BuildProgress extends Component
   {
       
      
      private var _progressBg:Bitmap;
      
      private var _progress:Bitmap;
      
      private var _progressMask:Bitmap;
      
      private var _progressTxt:FilterFrameText;
      
      private var _area1:Sprite;
      
      private var _area2:Sprite;
      
      private var _area3:Sprite;
      
      private var _tips:OneLineTip;
      
      public function BuildProgress()
      {
         super();
         initView();
         initEvents();
         setData(0,0,0);
      }
      
      private function initView() : void
      {
         _progress = ComponentFactory.Instance.creat("drgnBoatBuild.progressImg");
         addChild(_progress);
         _progressBg = ComponentFactory.Instance.creat("drgnBoatBuild.progress");
         addChild(_progressBg);
         _progressMask = ComponentFactory.Instance.creat("drgnBoatBuild.progressImg");
         addChild(_progressMask);
         _progress.mask = _progressMask;
         _progressTxt = ComponentFactory.Instance.creatComponentByStylename("drgnBoatBuild.progressTxt");
         addChild(_progressTxt);
         _tips = new OneLineTip();
         addChild(_tips);
         _tips.visible = false;
         PositionUtils.setPos(_tips,"drgnBoatBuild.tipsPos");
         _area1 = new Sprite();
         _area1.graphics.beginFill(0,0);
         _area1.graphics.drawRect(0,0,60,16);
         _area1.graphics.endFill();
         addChild(_area1);
         _area1.x = 21;
         _area1.y = 6;
         _area2 = new Sprite();
         _area2.graphics.beginFill(0,0);
         _area2.graphics.drawRect(0,0,60,16);
         _area2.graphics.endFill();
         addChild(_area2);
         _area2.x = 83;
         _area2.y = 6;
         _area3 = new Sprite();
         _area3.graphics.beginFill(0,0);
         _area3.graphics.drawRect(0,0,60,16);
         _area3.graphics.endFill();
         addChild(_area3);
         _area3.x = 146;
         _area3.y = 6;
      }
      
      private function initEvents() : void
      {
         _area1.addEventListener("mouseOver",__mouseOverHandler);
         _area1.addEventListener("mouseOut",__mouseOutHandler);
         _area2.addEventListener("mouseOver",__mouseOverHandler);
         _area2.addEventListener("mouseOut",__mouseOutHandler);
         _area3.addEventListener("mouseOver",__mouseOverHandler);
         _area3.addEventListener("mouseOut",__mouseOutHandler);
      }
      
      protected function __mouseOverHandler(event:MouseEvent) : void
      {
         _tips.visible = true;
         var _loc2_:* = event.target;
         if(_area1 !== _loc2_)
         {
            if(_area2 !== _loc2_)
            {
               if(_area3 === _loc2_)
               {
                  _tips.tipData = LanguageMgr.GetTranslation("drgnBoatBuild.stage2");
               }
            }
            else
            {
               _tips.tipData = LanguageMgr.GetTranslation("drgnBoatBuild.stage1");
            }
         }
         else
         {
            _tips.tipData = LanguageMgr.GetTranslation("drgnBoatBuild.stage0");
         }
      }
      
      protected function __mouseOutHandler(event:MouseEvent) : void
      {
         _tips.visible = false;
      }
      
      public function setData(completed:int, stage:int, total:int) : void
      {
         _progressMask.scaleX = completed / total;
         _progressTxt.text = LanguageMgr.GetTranslation("drgnBoatBuild.completed",int(completed / total * 100) + "%");
      }
      
      private function removeEvents() : void
      {
         _area1.removeEventListener("mouseOver",__mouseOverHandler);
         _area1.removeEventListener("mouseOut",__mouseOutHandler);
         _area2.removeEventListener("mouseOver",__mouseOverHandler);
         _area2.removeEventListener("mouseOut",__mouseOutHandler);
         _area3.removeEventListener("mouseOver",__mouseOverHandler);
         _area3.removeEventListener("mouseOut",__mouseOutHandler);
      }
      
      override public function dispose() : void
      {
         removeEvents();
         ObjectUtils.disposeObject(_progress);
         _progress = null;
         ObjectUtils.disposeObject(_progressBg);
         _progressBg = null;
         ObjectUtils.disposeObject(_progressMask);
         _progressMask = null;
         ObjectUtils.disposeObject(_progressTxt);
         _progressTxt = null;
         ObjectUtils.disposeObject(_tips);
         _tips = null;
         ObjectUtils.disposeObject(_area1);
         _area1 = null;
         ObjectUtils.disposeObject(_area2);
         _area2 = null;
         ObjectUtils.disposeObject(_area3);
         _area3 = null;
         super.dispose();
      }
      
      override public function get width() : Number
      {
         return displayWidth;
      }
      
      override public function get height() : Number
      {
         return displayHeight;
      }
   }
}
