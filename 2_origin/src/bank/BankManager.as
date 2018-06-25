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
      
      public function BankManager($inner:inner)
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
         var frame:Sprite = ClassUtils.CreatInstance("bank.view.BankMainFrameView");
         frame.width = 500;
         frame.height = 300;
         LayerManager.Instance.addToLayer(frame,3,true,1);
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
      
      private function __bankInfo(e:PkgEvent) : void
      {
         var pkg:PackageIn = e.pkg;
         var type:int = pkg.readInt();
         switch(int(type) - 1)
         {
            case 0:
               getBankInfo(pkg);
               break;
            case 1:
               addBankInfo(pkg);
               break;
            case 2:
               UpdateBankInfo(pkg);
         }
      }
      
      private function getBankInfo(pkg:PackageIn) : void
      {
         var i:int = 0;
         var info:* = null;
         while(_model.list.length)
         {
            _model.list.shift();
         }
         var size:int = pkg.readInt();
         for(i = 0; i < size; )
         {
            info = new BankRecordInfo();
            info.bankId = pkg.readInt();
            info.tempId = pkg.readInt();
            info.userId = pkg.readInt();
            info.Amount = pkg.readInt();
            info.begainTime = pkg.readDate();
            _model.list.push(info);
            i++;
         }
      }
      
      private function addBankInfo(pkg:PackageIn) : void
      {
         var info:BankRecordInfo = new BankRecordInfo();
         var size:int = pkg.readInt();
         info.bankId = pkg.readInt();
         info.tempId = pkg.readInt();
         info.userId = pkg.readInt();
         info.Amount = pkg.readInt();
         info.begainTime = pkg.readDate();
         _model.list.unshift(info);
         this.dispatchEvent(new GameBankEvent("bank_save_success"));
      }
      
      private function UpdateBankInfo(pkg:PackageIn) : void
      {
         var i:int = 0;
         var info:BankRecordInfo = new BankRecordInfo();
         var isDelete:Boolean = false;
         info.bankId = pkg.readInt();
         info.Amount = pkg.readInt();
         for(i = 0; i < _model.list.length; )
         {
            if(_model.list[i].bankId == info.bankId)
            {
               if(info.Amount == 0)
               {
                  _model.list.splice(i,1);
                  isDelete = true;
               }
               else
               {
                  _model.list[i].Amount = info.Amount;
               }
            }
            i++;
         }
         this.dispatchEvent(new GameBankEvent("bank_get_success",{"isDelete":isDelete}));
      }
      
      public function show() : void
      {
         var msg:* = null;
         var temLev:int = PlayerManager.Instance.Self.Grade;
         if(temLev < 21)
         {
            msg = LanguageMgr.GetTranslation("tank.bank.notOpen",21);
            MessageTipManager.getInstance().show(msg,0,true,1);
            return;
         }
         AssetModuleLoader.addRequestLoader(LoaderCreate.Instance.createBankLoader());
         AssetModuleLoader.addModelLoader("bank",5);
         SocketManager.Instance.out.sendBankUpdate(1);
         AssetModuleLoader.startCodeLoader(showFrame);
      }
      
      public function onDataComplete(analyzer:BankInvestmentDataAnalyzer) : void
      {
         _model.data = analyzer.data;
      }
      
      public function get totleSaveMoney() : int
      {
         var i:int = 0;
         _totleSaveMoney = 0;
         for(i = 0; i < _model.list.length; )
         {
            _totleSaveMoney = _totleSaveMoney + _model.list[i].Amount;
            i++;
         }
         return _totleSaveMoney;
      }
      
      public function get totleProfitMoney() : int
      {
         var i:int = 0;
         _totleProfitMoney = 0;
         for(i = 0; i < _model.list.length; )
         {
            _totleProfitMoney = _totleProfitMoney + getProfitNum(_model.list[i],true);
            i++;
         }
         return _totleProfitMoney;
      }
      
      public function getProfitNum(info:BankRecordInfo, isExpect:Boolean = false, getNum:int = 0, isAchieve:Boolean = true) : int
      {
         var profit:int = 0;
         var money:int = !!isExpect?info.Amount:int(getNum);
         var now:Number = TimeManager.Instance.Now().time;
         var day:int = (now - info.begainTime.time) / 1000 / 60 / 60 / 24;
         if(day == 0 && isExpect)
         {
            day = 1;
         }
         if(_model.data[info.tempId].DeadLine == 0)
         {
            profit = money * model.data[info.tempId].InterestRate * day / 10000;
         }
         else if(isAchieve)
         {
            profit = money * model.data[info.tempId].InterestRate * _model.data[info.tempId].DeadLine * 30 / 10000;
         }
         else
         {
            profit = money * model.data[info.tempId].InterestRate * day / 10000;
         }
         return profit;
      }
      
      public function isAchieve(info:BankRecordInfo) : Boolean
      {
         var boo:Boolean = false;
         var now:Number = TimeManager.Instance.Now().time;
         var day:int = (now - info.begainTime.time) / 1000 / 60 / 60 / 24;
         if(day >= _model.data[info.tempId].DeadLine * 30)
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
