require 'spec_helper'

describe Cielo::Bandeira do
  before do
    @bandeiras = Cielo::Bandeira.all
    @params = {
      numero => 123,
      valor => 100,
      :"url-retorno" => 'localhost',
      autorizar => 2,
      capturar => true
    }
  end
  it "each should have valid name, installments and debit" do
    @bandeiras.each do |bandeira|
      bandeira.name.should_not be_nil
      (1..6).include?(bandeira.installments).should be_true
      [true, false].include?(bandeira.debit).should be_true
    end
  end

  it "each should return a valid transaction for credit card installments" do
    @bandeiras.each do |bandeira|
      @params[:bandeira] = bandeira.name
      @params[:parcelas] = bandeira.installments if bandeira.installments >1
      @params[:produto] = (bandeira.installments ==1)? 1 : 3
      response = Cielo::Transaction.new.create!( @params )
      response[:transacao].should_not be_nil
    end
  end

  it 'each should return a valid transaction for debit card' do
    @bandeiras.select{|b| b.debit}.each do |bandeira|
      @params[:bandeira] = bandeira.name
      @params[:produto] = 'A'
      response = Cielo::Transaction.new.create!( @params )
      response[:transacao].should_not be_nil
    end
  end

end