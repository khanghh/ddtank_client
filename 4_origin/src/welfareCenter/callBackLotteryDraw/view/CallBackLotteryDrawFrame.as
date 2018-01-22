package welfareCenter.callBackLotteryDraw.view
{
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Sprite;
   import welfareCenter.callBackLotteryDraw.CallBackLotteryDrawManager;
   import welfareCenter.callBackLotteryDraw.LotteryDrawModel;
   
   public class CallBackLotteryDrawFrame extends Sprite implements Disposeable
   {
       
      
      private var _callBackLotteryDrawInitSp:CallBackLotteryDrawInitSp;
      
      private var _callBackLotteryDrawSp:CallBackLotteryDrawSp;
      
      public function CallBackLotteryDrawFrame()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         var _loc2_:CallBackLotteryDrawManager = CallBackLotteryDrawManager.instance;
         var _loc1_:LotteryDrawModel = _loc2_.callBackLotteryDrawModel;
         if(_loc1_.phase == 0 && _loc2_.getCallBackLeftSec() > 0 || _loc1_.awardArr == null || _loc1_.awardArr.length == 0)
         {
            _callBackLotteryDrawInitSp = new CallBackLotteryDrawInitSp();
            addChild(_callBackLotteryDrawInitSp);
         }
         else
         {
            _callBackLotteryDrawSp = new CallBackLotteryDrawSp();
            addChild(_callBackLotteryDrawSp);
         }
      }
      
      public function dispose() : void
      {
         ObjectUtils.disposeAllChildren(this);
         _callBackLotteryDrawInitSp = null;
         _callBackLotteryDrawSp = null;
      }
   }
}
