require 'spec_helper'

describe 'extlib::cidr_to_range' do
  it 'exists' do
    is_expected.not_to be_nil
  end

  context 'when called with no parameters' do
    it { is_expected.to run.with_params.and_raise_error(ArgumentError) }
  end

  context 'when called with a Integer' do
    it { is_expected.to run.with_params(42).and_raise_error(ArgumentError) }
  end

  context 'when called with a String thats not an ip address' do
    it { is_expected.to run.with_params('42').and_raise_error(ArgumentError) }
  end

  context 'when called with an IP Address that is not in the CIDR notation' do
    it { is_expected.to run.with_params('127.0.0.1').and_raise_error(ArgumentError) }
  end

  context 'when called with an IP Address that is not in the CIDR notation' do
    it { is_expected.to run.with_params('fe80::800:27ff:fe00:0').and_raise_error(ArgumentError) }
  end

  context 'when called with an IPv4 CIDR' do
    it { is_expected.to run.with_params('127.0.0.0/30').and_return(['127.0.0.1', '127.0.0.2']) }
  end

  context 'when called with an IPv6 CIDR' do
    it { is_expected.to run.with_params('fe80::5054:ff:fe47:4a37/126').and_return(['fe80::5054:ff:fe47:4a35', 'fe80::5054:ff:fe47:4a36']) }
  end
end
