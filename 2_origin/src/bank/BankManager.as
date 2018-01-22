package bank
{
   import bank.analyzer.BankInvestmentDataAnalyzer;
   import bank.data.BankInvestmentModel;
   import bank.data.BankRecordInfo;
   import bank.data.GameBankEvent;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.utils.ClassUtils;
   import ddt.events.PkgEvent;
   import ddt.loader.LoaderCreate;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.TimeManager;
   import ddt.utils.AssetModuleLoader;
   import flash.display.Sprite;
   import flash.events.EventDispatcher;
   import hallIcon.HallIconManager;
   import road7th.comm.PackageIn;
   
   public class BankManager extends EventDispatcher
   {
      
      public static const BANK_GETINFO:int = 1;
      
      public static const BANK_ADD:int = 2;
      
      public static const BANK_UPDATA:int = 3;
      
      public static const BANK_UPDATE_TASK:int = 4;
      
      public static const BANK_SAVE_OR_GET_VIEW:int = 0;
      
      public static const BANK_SAVE_VIEW:int = 1;
      
      public static const BANK_GET_VIEW:int = 2;
      
      public static const BANK_SAVE_RECORD_VIEW:int = 3;
      
      private static var _instance:BankManager;
       
      
      private var _model:BankInvestmentModel;
      
      private var _totleSaveMoney:int = 0;
      
      private var _totleProfitMoney:int = 0;
      
      private var _icon:BaseButton;
      
      public function BankManager(param1:inner)
      {
         super(null);
      }
      
      public static function get instance() : BankManager
      {
         if(_instance == null)
         {
            _instance = new BankManager(new inner());
         }
         return _instance;
      }
      
      public function setup() : void
      {
         _model = new BankInvestmentModel();
         SocketManager.Instance.addEventListener(PkgEvent.format(389),__bankInfo);
      }
      
      private function showFrame() : void
      {
         var _loc1_:Sprite = ClassUtils.CreatInstance("bank.view.BankMainFrameView");
         _loc1_.width = 500;
         _loc1_.height = 300;
         LayerManager.Instance.addToLayer(_loc1_,3,true,1);
      }
      
      public function showIcon() : void
      {
         if(PlayerManager.Instance.Self.Grade >= 21)
         {
            HallIconManager.instance.updateSwitchHandler("bank",true);
         }
         else
         {
            HallIconManager.instance.executeCacheRightIconLevelLimit("bank",21);
         }
      }
      
      private function __bankInfo(param1:PkgEvent) : void
      {
         var _loc2_:PackageIn = param1.pkg;
         var _loc3_:int = _loc2_.readInt();
         switch(int(_loc3_) - 1)
         {
            case 0:
               getBankInfo(_loc2_);
               break;
            case 1:
               addBankInfo(_loc2_);
               break;
            case 2:
               UpdateBankInfo(_loc2_);
         }
      }
      
      private function getBankInfo(param1:PackageIn) : void
      {
         var _loc3_:int = 0;
         var _loc2_:* = null;
         while(_model.list.length)
         {
            _model.list.shift();
         }
         var _loc4_:int = param1.readInt();
         _loc3_ = 0;
         while(_loc3_ < _loc4_)
         {
            _loc2_ = new BankRecordInfo();
            _loc2_.bankId = param1.readInt();
            _loc2_.tempId = param1.readInt();
            _loc2_.userId = param1.readInt();
            _loc2_.Amount = param1.readInt();
            _loc2_.begainTime = param1.readDate();
            _model.list.push(_loc2_);
            _loc3_++;
         }
      }
      
      private function addBankInfo(param1:PackageIn) : void
      {
         var _loc3_:BankRecordInfo = new BankRecordInfo();
         var _loc2_:int = param1.readInt();
         _loc3_.bankId = param1.readInt();
         _loc3_.tempId = param1.readInt();
         _loc3_.userId = param1.readInt();
         _loc3_.Amount = param1.readInt();
         _loc3_.begainTime = param1.readDate();
         _model.list.unshift(_loc3_);
         this.dispatchEvent(new GameBankEvent("bank_save_success"));
      }
      
      private function UpdateBankInfo(param1:PackageIn) : void
      {
         var _loc3_:int = 0;
         var _loc4_:BankRecordInfo = new BankRecordInfo();
         var _loc2_:Boolean = false;
         _loc4_.bankId = param1.readInt();
         _loc4_.Amount = param1.readInt();
         _loc3_ = 0;
         while(_loc3_ < _model.list.length)
         {
            if(_model.list[_loc3_].bankId == _loc4_.bankId)
            {
               if(_loc4_.Amount == 0)
               {
                  _model.list.splice(_loc3_,1);
                  _loc2_ = true;
               }
               else
               {
                  _model.list[_loc3_].Amount = _loc4_.Amount;
               }
            }
            _loc3_++;
         }
         this.dispatchEvent(new GameBankEvent("bank_get_success",{"isDelete":_loc2_}));
      }
      
      public function show() : void
      {
         var _loc2_:* = null;
         var _loc1_:int = PlayerManager.Instance.Self.Grade;
         if(_loc1_ < 21)
         {
            _loc2_ = LanguageMgr.GetTranslation("tank.bank.notOpen",21);
            MessageTipManager.getInstance().show(_loc2_,0,true,1);
            return;
         }
         AssetModuleLoader.addRequestLoader(LoaderCreate.Instance.createBankLoader());
         AssetModuleLoader.addModelLoader("bank",5);
         SocketManager.Instance.out.sendBankUpdate(1);
         AssetModuleLoader.startCodeLoader(showFrame);
      }
      
      public function onDataComplete(param1:BankInvestmentDataAnalyzer) : void
      {
         _model.data = param1.data;
      }
      
      public function get totleSaveMoney() : int
      {
         var _loc1_:int = 0;
         _totleSaveMoney = 0;
         _loc1_ = 0;
         while(_loc1_ < _model.list.length)
         {
            _totleSaveMoney = _totleSaveMoney + _model.list[_loc1_].Amount;
            _loc1_++;
         }
         return _totleSaveMoney;
      }
      
      public function get totleProfitMoney() : int
      {
         var _loc1_:int = 0;
         _totleProfitMoney = 0;
         _loc1_ = 0;
         while(_loc1_ < _model.list.length)
         {
            _totleProfitMoney = _totleProfitMoney + getProfitNum(_model.list[_loc1_],true);
            _loc1_++;
         }
         return _totleProfitMoney;
      }
      
      public function getProfitNum(param1:BankRecordInfo, param2:Boolean = false, param3:int = 0, param4:Boolean = true) : int
      {
         var _loc5_:int = 0;
         var _loc7_:int = !!param2?param1.Amount:int(param3);
         var _loc6_:Number = TimeManager.Instance.Now().time;
         var _loc8_:int = (_loc6_ - param1.begainTime.time) / 1000 / 60 / 60 / 24;
         if(_loc8_ == 0 && param2)
         {
            _loc8_ = 1;
         }
         if(_model.data[param1.tempId].DeadLine == 0)
         {
            _loc5_ = _loc7_ * model.data[param1.tempId].InterestRate * _loc8_ / 10000;
         }
         else if(param4)
         {
            _loc5_ = _loc7_ * model.data[param1.tempId].InterestRate * _model.data[param1.tempId].DeadLine * 30 / 10000;
         }
         else
         {
            _loc5_ = _loc7_ * model.data[param1.tempId].InterestRate * _loc8_ / 10000;
         }
         return _loc5_;
      }
      
      public function isAchieve(param1:BankRecordInfo) : Boolean
      {
         var _loc2_:Boolean = false;
         var _loc3_:Number = TimeManager.Instance.Now().time;
         var _loc4_:int = (_loc3_ - param1.begainTime.time) / 1000 / 60 / 60 / 24;
         if(_loc4_ >= _model.data[param1.tempId].DeadLine * 30)
         {
            return true;
         }
         return false;
      }
      
      public function get model() : BankInvestmentModel
      {
         return _model;
      }
   }
}

class inner
{
    
   
   function inner()
   {
      super();
   }
}
