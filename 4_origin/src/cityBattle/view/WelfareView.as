package cityBattle.view
{
   import cityBattle.CityBattleManager;
   import cityBattle.data.WelfareInfo;
   import cityBattle.event.CityBattleEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ClassUtils;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.box.BoxGoodsTempInfo;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.manager.BossBoxManager;
   import ddt.manager.ItemManager;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class WelfareView extends Sprite implements Disposeable
   {
       
      
      private var _bg:Bitmap;
      
      private var _myScoreTxt:FilterFrameText;
      
      private var _box:Sprite;
      
      private var _winBtn:MovieClip;
      
      private var _prize:WinnerPrizeView;
      
      public function WelfareView()
      {
         super();
         init();
      }
      
      private function init() : void
      {
         var _loc7_:int = 0;
         var _loc6_:* = null;
         var _loc5_:int = 0;
         var _loc4_:* = null;
         var _loc2_:* = null;
         _bg = ComponentFactory.Instance.creatBitmap("asset.cityBattle.bg3");
         addChild(_bg);
         _myScoreTxt = ComponentFactory.Instance.creatComponentByStylename("welfare.myscore.txt");
         addChild(_myScoreTxt);
         _myScoreTxt.text = String(CityBattleManager.instance.myScore);
         _winBtn = ClassUtils.CreatInstance("asset.cityBattle.box");
         if(CityBattleManager.instance.now < 8 && CityBattleManager.instance.now > 0)
         {
            addChild(_winBtn);
         }
         PositionUtils.setPos(_winBtn,"welfare.boxPos");
         _winBtn.addEventListener("click",clickHandler);
         _winBtn.addEventListener("mouseOver",overHandler);
         _winBtn.addEventListener("mouseOut",outHandler);
         _box = new Sprite();
         addChild(_box);
         var _loc3_:int = 0;
         var _loc1_:int = 0;
         _loc7_ = 0;
         for(; _loc7_ < CityBattleManager.instance.welfareList.length; _loc7_++)
         {
            _loc6_ = CityBattleManager.instance.welfareList[_loc7_];
            if(_loc6_.Quality == 2)
            {
               if(CityBattleManager.instance.now < 8 && CityBattleManager.instance.now > 0)
               {
                  _loc5_ = CityBattleManager.instance.now;
               }
               else
               {
                  _loc5_ = 7;
               }
               if(_loc6_.Probability == _loc5_)
               {
                  _loc4_ = new WelfareCell();
                  _loc4_.info = _loc6_;
                  _loc4_.x = 94 * _loc3_ + 319;
                  _loc4_.y = 180;
                  _box.addChild(_loc4_);
                  _loc3_++;
                  continue;
               }
            }
            if(_loc6_.Quality == 3)
            {
               _loc2_ = new WelfareCell();
               _loc2_.info = _loc6_;
               if(_loc1_ <= 2)
               {
                  _loc2_.x = 94 * _loc1_ + 368;
                  _loc2_.y = 365;
               }
               else
               {
                  _loc2_.x = 94 * (_loc1_ - 3) + 318;
                  _loc2_.y = 455;
               }
               _box.addChild(_loc2_);
               _loc1_++;
               continue;
            }
         }
         CityBattleManager.instance.addEventListener("scoreChange",_scoreChange);
      }
      
      private function _scoreChange(param1:CityBattleEvent) : void
      {
         _myScoreTxt.text = String(CityBattleManager.instance.myScore);
      }
      
      private function overHandler(param1:MouseEvent) : void
      {
         _winBtn.gotoAndStop(2);
      }
      
      private function outHandler(param1:MouseEvent) : void
      {
         _winBtn.gotoAndStop(1);
      }
      
      private function clickHandler(param1:MouseEvent) : void
      {
         var _loc7_:int = 0;
         var _loc5_:* = null;
         var _loc4_:int = 0;
         var _loc2_:* = null;
         var _loc6_:* = null;
         _winBtn.gotoAndStop(1);
         var _loc3_:Array = [];
         _loc7_ = 0;
         while(_loc7_ < CityBattleManager.instance.welfareList.length)
         {
            _loc5_ = CityBattleManager.instance.welfareList[_loc7_];
            if(_loc5_.Quality == 5 && _loc5_.Probability == CityBattleManager.instance.now)
            {
               _loc4_ = 0;
               while(_loc4_ < BossBoxManager.instance.cityBattleTempInfoList[_loc5_.TemplateID].length)
               {
                  _loc2_ = BossBoxManager.instance.cityBattleTempInfoList[_loc5_.TemplateID][_loc4_];
                  _loc6_ = ItemManager.fillByID(_loc2_.TemplateId);
                  _loc6_.IsBinds = _loc2_.IsBind;
                  _loc6_.LuckCompose = _loc2_.LuckCompose;
                  _loc6_.DefendCompose = _loc2_.DefendCompose;
                  _loc6_.AttackCompose = _loc2_.AttackCompose;
                  _loc6_.AgilityCompose = _loc2_.AgilityCompose;
                  _loc6_.StrengthenLevel = _loc2_.StrengthenLevel;
                  _loc6_.ValidDate = _loc2_.ItemValid;
                  _loc6_.Count = _loc2_.ItemCount;
                  _loc3_.push(_loc6_);
                  _loc4_++;
               }
            }
            _loc7_++;
         }
         _prize = ComponentFactory.Instance.creat("welfare.winnerPrizeView");
         _prize.goodsList = _loc3_;
         LayerManager.Instance.addToLayer(_prize,3,true,1);
      }
      
      public function dispose() : void
      {
         CityBattleManager.instance.removeEventListener("scoreChange",_scoreChange);
         _winBtn.removeEventListener("click",clickHandler);
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_myScoreTxt);
         _myScoreTxt = null;
         ObjectUtils.disposeObject(_box);
         _box = null;
         ObjectUtils.disposeObject(_winBtn);
         _winBtn = null;
      }
   }
}
