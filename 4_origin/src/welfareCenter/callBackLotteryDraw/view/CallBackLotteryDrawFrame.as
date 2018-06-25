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
         var manager:CallBackLotteryDrawManager = CallBackLotteryDrawManager.instance;
         var model:LotteryDrawModel = manager.callBackLotteryDrawModel;
         if(model.phase == 0 && manager.getCallBackLeftSec() > 0 || model.awardArr == null || model.awardArr.length == 0)
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
