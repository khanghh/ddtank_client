package quest
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.utils.ObjectUtils;
   import flash.geom.Point;
   import flash.utils.Timer;
   
   public class QuestBubble extends Component
   {
       
      
      private var _bg:ScaleBitmapImage;
      
      private var _itemVec:Vector.<BubbleItem>;
      
      private var _time:Timer;
      
      private var _questModeArr:Array;
      
      public const ACTISOVER:String = "act_is_over";
      
      public const SHOWTASKTIP:String = "show_task_tip";
      
      private var _regularPos:Point;
      
      private var _basePos:Point;
      
      private const BASEWIDTH:int = 25;
      
      public function QuestBubble()
      {
         super();
      }
      
      public function start(param1:Array) : void
      {
         _questModeArr = param1;
      }
      
      public function show() : void
      {
         super.init();
         _itemVec = new Vector.<BubbleItem>();
         _bg = ComponentFactory.Instance.creatComponentByStylename("toolbar.bubbleBg");
         _regularPos = ComponentFactory.Instance.creatCustomObject("toolbar.bubbleRegularPos");
         _basePos = ComponentFactory.Instance.creatCustomObject("toolbar.bubbleBasePos");
         addChild(_bg);
         _countInfo();
         x = _regularPos.x;
         y = _regularPos.y - _bg.height;
         LayerManager.Instance.addToLayer(this,2,false,0);
      }
      
      private function _countInfo() : void
      {
         var _loc2_:int = 0;
         var _loc1_:* = null;
         _loc2_ = 0;
         while(_loc2_ < _questModeArr.length)
         {
            _loc1_ = new BubbleItem();
            addChild(_loc1_);
            _loc1_.setTextInfo(_questModeArr[_loc2_].txtI,_questModeArr[_loc2_].txtII,_questModeArr[_loc2_].txtIII);
            _loc1_.y = _loc1_.height * _loc2_ * 5 / 4;
            _itemVec.push(_loc1_);
            _loc2_++;
         }
         _bg.height = (1 + _itemVec.length) * 25;
      }
      
      override public function dispose() : void
      {
         var _loc1_:int = 0;
         super.dispose();
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         if(_itemVec != null)
         {
            while(_loc1_ < _itemVec.length)
            {
               ObjectUtils.disposeObject(_itemVec[_loc1_]);
               _loc1_++;
            }
            _itemVec = null;
         }
      }
   }
}
